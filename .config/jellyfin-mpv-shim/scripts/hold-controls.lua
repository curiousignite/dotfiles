local utils = require("mp.utils")

local threshold = 0.200
local skip_available = false
local terminating = false
local previous_speed = nil
local mouse_callback = nil
local mouse_rebind_timer = nil
local sources = {
    space = {pressed = false, holding = false, timer = nil, generation = 0, down_at = nil},
    mouse = {pressed = false, holding = false, timer = nil, generation = 0, down_at = nil},
}

local function send_event(payload)
    mp.commandv("script-message", "mpvtk-event", payload)
end

local function skip()
    if skip_available and not terminating then
        send_event('{"t":"hudskip"}')
    end
end

mp.add_key_binding("s", "shim-hud-skip-lower", skip)
mp.add_key_binding("S", "shim-hud-skip-upper", skip)

local function release(source)
    if not source.holding then
        return
    end

    source.holding = false
    if not sources.space.holding and not sources.mouse.holding then
        if previous_speed ~= nil then
            mp.set_property_number("speed", previous_speed)
        end
        previous_speed = nil
    end
end

local function cancel(source)
    if source.timer ~= nil then
        source.timer:kill()
        source.timer = nil
    end
    source.generation = source.generation + 1
    source.pressed = false
    source.down_at = nil
    release(source)
end

local function activate(source)
    source.timer = nil
    if terminating or not source.pressed or source.holding then
        return
    end

    if not sources.space.holding and not sources.mouse.holding then
        previous_speed = mp.get_property_number("speed")
    end
    source.holding = true
    mp.set_property_number("speed", 2)
end

local function handle_press(source, on_tap)
    return function(event)
        if terminating then
            return
        end
        if event.event == "down" then
            if source.pressed then
                return
            end
            source.pressed = true
            source.down_at = mp.get_time()
            source.generation = source.generation + 1
            local generation = source.generation
            source.timer = mp.add_timeout(threshold, function()
                if generation == source.generation then
                    activate(source)
                end
            end)
        elseif event.event == "up" then
            if not source.pressed then
                return
            end
            local elapsed = mp.get_time() - source.down_at
            local was_holding = source.holding
            local canceled = event.canceled == true
            cancel(source)
            if was_holding then
                return
            end
            if not canceled and elapsed < threshold then
                on_tap()
            end
        end
    end
end

local function install_mouse_binding()
    if terminating then
        return
    end
    mp.remove_key_binding("shim-hold-speed-mouse")
    mp.add_forced_key_binding("MBTN_LEFT", "shim-hold-speed-mouse", mouse_callback, {complex = true})
end

local function schedule_mouse_rebind()
    if mouse_rebind_timer ~= nil then
        mouse_rebind_timer:kill()
    end
    mouse_rebind_timer = mp.add_timeout(0, function()
        mouse_rebind_timer = nil
        install_mouse_binding()
    end)
end

local function replay_mouse_click()
    if mp.get_property_native("user-data/mpvtk/active") ~= true then
        send_event('{"t":"pause"}')
        return
    end
    local pos = mp.get_property_native("mouse-pos")
    if type(pos) == "table" and type(pos.x) == "number" and type(pos.y) == "number" then
        mp.commandv("script-message-to", "renderer", "mpvtk-debug",
            utils.format_json({cmd = "click", x = pos.x, y = pos.y}))
    end
end

local space_callback = handle_press(sources.space, function()
    send_event('{"t":"pause"}')
end)
mouse_callback = handle_press(sources.mouse, replay_mouse_click)
mp.add_key_binding("SPACE", "shim-hold-speed-key", space_callback, {complex = true})
install_mouse_binding()

mp.register_script_message("mpvtk-hud-skip", function(label)
    if not terminating then
        skip_available = label ~= nil and label ~= ""
    end
end)

mp.register_script_message("mpvtk-event", function(payload)
    local ok, event = pcall(utils.parse_json, payload)
    if ok and type(event) == "table" and event.t == "hud" then
        schedule_mouse_rebind()
    end
end)

local function reset()
    cancel(sources.space)
    cancel(sources.mouse)
    skip_available = false
end

mp.register_event("end-file", function()
    terminating = false
    reset()
end)
mp.register_event("shutdown", function()
    terminating = true
    if mouse_rebind_timer ~= nil then
        mouse_rebind_timer:kill()
        mouse_rebind_timer = nil
    end
    reset()
end)
