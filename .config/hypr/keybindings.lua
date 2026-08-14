-- User keybinding overrides

local MOD = hyde.config.modifiers.main or "SUPER"

local function flags(description, extra)
    extra = extra or {}
    extra.description = description
    return extra
end

local function exec(command)
    return hl.dsp.exec_cmd(command)
end

-- Move tiled windows directionally.
-- Move floating windows by fixed pixel amount.
local function move_window(direction, pixels)
    local deltas = {
        left  = {-1,  0},
        right = { 1,  0},
        up    = { 0, -1},
        down  = { 0,  1},
    }

    local delta = assert(deltas[direction], "Invalid direction: " .. direction)

    return function()
        local window = hl.get_active_window()
        if not window then
            return
        end

        if window.floating then
            hl.dispatch(hl.dsp.window.move({
                x = delta[1] * pixels,
                y = delta[2] * pixels,
                relative = true,
                window = window,
            }))
        else
            hl.dispatch(hl.dsp.window.move({
                direction = direction,
                window = window,
            }))
        end
    end
end

--------------------------------------------------
-- Window management
--------------------------------------------------

hl.bind(
    "ALT + Return",
    hl.dsp.window.fullscreen({
        mode = "fullscreen",
        action = "toggle",
    }),
    flags("[Window Management] toggle fullscreen")
)

hl.bind(
    "ALT+TAB",
    hl.dsp.exec_cmd(hyde.sh.altab("--next"))

)

hl.bind(
    MOD .. " + BackSpace",
    exec(hyde.sh.session.logout.launcher()),
    flags("[Window Management] logout menu")
)

-- hl.bind(
--     "CTRL + ALT + W",
--     exec("pkill -x waybar; hyde-shell waybar --watch"),
--     flags("[Window Management] restart Waybar")
-- )

hl.bind(
    MOD .. " + U",
    hl.dsp.layout("togglesplit"),
    flags("[Layout Management|Dwindle] toggle split")
)

--------------------------------------------------
-- HJKL focus
--------------------------------------------------

hl.bind(
    MOD .. " + H",
    hl.dsp.focus({direction = "left"}),
    flags("[Window Management|Focus] focus left")
)

hl.bind(
    MOD .. " + L",
    hl.dsp.focus({direction = "right"}),
    flags("[Window Management|Focus] focus right")
)

hl.bind(
    MOD .. " + K",
    hl.dsp.focus({direction = "up"}),
    flags("[Window Management|Focus] focus up")
)

hl.bind(
    MOD .. " + J",
    hl.dsp.focus({direction = "down"}),
    flags("[Window Management|Focus] focus down")
)

--------------------------------------------------
-- HJKL resize
--------------------------------------------------

hl.bind(
    MOD .. " + CTRL + L",
    hl.dsp.window.resize({x = 30, y = 0, relative = true}),
    flags("[Window Management|Resize] resize right", {repeating = true})
)

hl.bind(
    MOD .. " + CTRL + H",
    hl.dsp.window.resize({x = -30, y = 0, relative = true}),
    flags("[Window Management|Resize] resize left", {repeating = true})
)

hl.bind(
    MOD .. " + CTRL + K",
    hl.dsp.window.resize({x = 0, y = -30, relative = true}),
    flags("[Window Management|Resize] resize up", {repeating = true})
)

hl.bind(
    MOD .. " + CTRL + J",
    hl.dsp.window.resize({x = 0, y = 30, relative = true}),
    flags("[Window Management|Resize] resize down", {repeating = true})
)

--------------------------------------------------
-- HJKL move
--------------------------------------------------

hl.bind(
    MOD .. " + SHIFT + H",
    move_window("left", 30),
    flags("[Window Management|Move] move left", {repeating = true})
)

hl.bind(
    MOD .. " + SHIFT + L",
    move_window("right", 30),
    flags("[Window Management|Move] move right", {repeating = true})
)

hl.bind(
    MOD .. " + SHIFT + K",
    move_window("up", 30),
    flags("[Window Management|Move] move up", {repeating = true})
)

hl.bind(
    MOD .. " + SHIFT + J",
    move_window("down", 30),
    flags("[Window Management|Move] move down", {repeating = true})
)

--------------------------------------------------
-- Applications
--------------------------------------------------

hl.bind(
    MOD .. " + T",
    exec("kitty"),
    flags("[Launcher|Apps] terminal")
)

hl.bind(
    MOD .. " + E",
    exec("dolphin"),
    flags("[Launcher|Apps] Dolphin")
)

hl.bind(
    MOD .. " + F",
    exec("helium-browser"),
    flags("[Launcher|Apps] browser")
)

hl.bind(
    MOD .. " + O",
    exec("obsidian"),
    flags("[Launcher|Apps] Obsidian")
)

hl.bind(
    MOD .. " + D",
    exec("discord"),
    flags("[Launcher|Apps] Discord")
)

--------------------------------------------------
-- Screenshots
--------------------------------------------------

hl.bind(
    "PRINT",
    hl.dsp.exec_cmd("hyde-shell screenshot sf"),
    flags("[Utilities|Screenshot] capture all monitors", {
        locked = true,
    })
)

hl.bind(
    "SHIFT + PRINT",
    hl.dsp.exec_cmd("hyde-shell screenshot s"),
    flags("[Utilities|Screenshot] capture selected area", {
        locked = true,
    })
)

hl.bind(
    "CONTROL + PRINT",
    hl.dsp.exec_cmd("hyde-shell screenshot sc"),
    flags("[Utilities|Screenshot] OCR selected area", {
        locked = true,
    })
)

--------------------------------------------------
-- Hardware
--------------------------------------------------

hl.bind(
    "XF86Calculator",
    exec(hyde.sh.menu.calculator()),
    flags("[Hardware Controls] calculator", {locked = true})
)

--------------------------------------------------
-- Multi-monitor workspace action
--------------------------------------------------

hl.bind(
    MOD .. " + SHIFT + U",
    hl.dsp.workspace.swap_monitors({
        monitor1 = "current",
        monitor2 = "+1",
    }),
    flags("[Workspaces] swap active workspaces")
)

--------------------------------------------------
-- Special workspace / scratchpad
--------------------------------------------------

-- Remove HyDE bindings occupying these combinations.
hl.unbind("CTRL + DELETE")
hl.unbind(MOD .. " + S")
hl.unbind(MOD .. " + SHIFT + S")
hl.unbind(MOD .. " + ALT + S")

hl.bind(
    MOD .. " + S",
    hl.dsp.workspace.toggle_special(),
    flags("[Workspaces|Special] toggle scratchpad")
)

hl.bind(
    MOD .. " + SHIFT + S",
    hl.dsp.window.move({
        workspace = "special",
    }),
    flags("[Workspaces|Special] move window and follow")
)

hl.bind(
    MOD .. " + ALT + S",
    hl.dsp.window.move({
        workspace = "special",
        follow = false,
    }),
    flags("[Workspaces|Special] move window silently")
)

hl.unbind(MOD .. " + C")

--------------------------------------------------
-- Alt-Tab without notification
--------------------------------------------------

hl.unbind("ALT+TAB")
hl.unbind("ALT+SHIFT+TAB")
hl.unbind("ALT + ALT_R")
hl.unbind("ALT + ALT_L")

hl.bind(
    "ALT+TAB",
    hl.dsp.exec_cmd("hyde-shell altab --next --no-notify"),
    {
        description = "[Window Management|Alt-Tab] cycle next",
        transparent = true,
    }
)

hl.bind(
    "ALT+SHIFT+TAB",
    hl.dsp.exec_cmd("hyde-shell altab --prev --no-notify"),
    {
        description = "[Window Management|Alt-Tab] cycle previous",
        transparent = true,
    }
)

hl.bind(
    "ALT + ALT_R",
    hl.dsp.exec_cmd("hyde-shell altab --apply --no-notify"),
    {
        description = "[Window Management|Alt-Tab] switch",
        release = true,
        transparent = true,
    }
)

hl.bind(
    "ALT + ALT_L",
    hl.dsp.exec_cmd("hyde-shell altab --apply --no-notify"),
    {
        description = "[Window Management|Alt-Tab] switch",
        release = true,
        transparent = true,
    }
)

--------------------------------------------------
-- Whisper
--------------------------------------------------

local home = assert(os.getenv("HOME"), "HOME environment variable is unavailable")

hl.bind(
    "SUPER + SHIFT + D",
    hl.dsp.exec_cmd(home .. "/.local/bin/hyprwhspr-toggle"),
    {
        description = "[Utilities] Toggle local dictation",
    }
)
hl.bind(
    "SUPER + PAUSE",
    hl.dsp.exec_cmd(home .. "/.local/bin/hyprwhspr-toggle"),
    {
        description = "[Utilities] Toggle local dictation",
    }
)
