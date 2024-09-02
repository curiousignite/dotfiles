local wezterm = require 'wezterm'
local io = require 'io'
local os = require 'os'
local act = wezterm.action
local config = wezterm.config_builder()


config.color_scheme = 'Catppuccin Mocha (Gogh)'
config.font = wezterm.font 'Hack Nerd Font Mono'
config.window_background_opacity = 0.85
config.text_background_opacity = 1.0
config.enable_scroll_bar = false
config.font_size = 14
config.line_height = 1
config.use_fancy_tab_bar = false
config.adjust_window_size_when_changing_font_size = false
config.inactive_pane_hsb = { saturation = 0.8, brightness = 0.7 }
config.native_macos_fullscreen_mode = true
config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.animation_fps = 60
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
-- config.front_end = 'OpenGL'
config.front_end = 'WebGpu'
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}
for _, gpu in ipairs(wezterm.gui.enumerate_gpus()) do
    if gpu.device_type == 'DiscreteGpu' then
        config.front_end = 'OpenGL'
        break
    end
end

-- config.background = {
--     {
--         source = {
--             File = wezterm.home_dir .. '/.config/background.png',
--         },
--         hsb = {
--             hue = 1.0,
--             saturation = 0.85,
--             brightness = 0.5,
--         },
--     },
--
-- }
local TITLEBAR_COLOR = '#333333'
config.window_frame = {
    font = wezterm.font { family = 'Hack', weight = 'Bold' },
    font_size = 13.0,
    active_titlebar_bg = TITLEBAR_COLOR,
    inactive_titlebar_bg = TITLEBAR_COLOR,
}


wezterm.on('update-status', function(window, pane)
    local cells = {}

    -- Figure out the hostname of the pane on a best-effort basis
    local hostname = wezterm.hostname()
    local cwd_uri = pane:get_current_working_dir()
    if cwd_uri and cwd_uri.host then
        hostname = cwd_uri.host
    end
    table.insert(cells, ' ' .. hostname)

    -- Format date/time in this style: "Wed Mar 3 08:14"
    local date = wezterm.strftime ' %a %b %-d %H:%M'
    table.insert(cells, date)

    -- Add an entry for each battery (typically 0 or 1)
    local batt_icons = { '', '', '', '', '' }
    for _, b in ipairs(wezterm.battery_info()) do
        local curr_batt_icon = batt_icons[math.ceil(b.state_of_charge * #batt_icons)]
        table.insert(cells, string.format('%s %.0f%%', curr_batt_icon, b.state_of_charge * 100))
    end

    -- Color palette for each cell
    local text_fg = '#c0c0c0'
    local colors = {
        TITLEBAR_COLOR,
        '#3c1361',
        '#52307c',
        '#663a82',
        '#7c5295',
        '#b491c8',
    }

    local elements = {}
    while #cells > 0 and #colors > 1 do
        local text = table.remove(cells, 1)
        local prev_color = table.remove(colors, 1)
        local curr_color = colors[1]

        table.insert(elements, { Background = { Color = prev_color } })
        table.insert(elements, { Foreground = { Color = curr_color } })
        table.insert(elements, { Text = '' })
        table.insert(elements, { Background = { Color = curr_color } })
        table.insert(elements, { Foreground = { Color = text_fg } })
        table.insert(elements, { Text = ' ' .. text .. ' ' })
    end
    window:set_right_status(wezterm.format(elements))
end)

config.hyperlink_rules = {
    {
        regex = [[https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)]],
        format = '$0',
    },
    {
        regex = [[["]?([\w\d]{1}[-\w\d]+)(\/){1}([-\w\d\.]+)["]?]],
        format = 'https://www.github.com/$1/$3',
    } }
local function is_inside_vim(pane)
    local tty = pane:get_tty_name()
    if tty == nil then return false end
    local success, stdout, stderr = wezterm.run_child_process { 'sh', '-c',
        'ps -o state= -o comm= -t' .. wezterm.shell_quote_arg(tty) .. ' | ' ..
        'grep -iqE \'^[^TXZ ]+ +(\\S+\\/)?g?(view|l?nvim?x?)(diff)?$\'' }
    return success
end
local function is_outside_vim(pane) return not is_inside_vim(pane) end
local function bind_if(cond, key, mods, action)
    local function callback(win, pane)
        if cond(pane) then
            win:perform_action(action, pane)
        else
            win:perform_action(act.SendKey({ key = key, mods = mods }), pane)
        end
    end
    return { key = key, mods = mods, action = wezterm.action_callback(callback) }
end

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    config.default_prog = { 'pwsh.exe', '-NoLogo' }
    -- config.win32_system_backdrop = 'Acrylic'
    -- config.window_background_opacity = 0
    -- config.win32_system_backdrop = 'Tabbed'
elseif wezterm.target_triple == 'x86_64-apple-darwin' or wezterm.target_triple == 'aarch64-apple-darwin' then
    config.window_background_opacity = 0.3
    config.macos_window_background_blur = 20
    --TBD
elseif wezterm.target_triple == 'x86_64-unknown-linux-gnu' then
    --TBD
end



wezterm.on('trigger-vim-with-scrollback', function(window, pane)
    -- Retrieve the text from the pane
    local text = pane:get_lines_as_text(pane:get_dimensions().scrollback_rows)

    -- Create a temporary file to pass to vim
    local name = os.tmpname()
    local f = io.open(name, 'w+')
    f:write(text)
    f:flush()
    f:close()

    -- Open a new window running vim and tell it to open the file
    window:perform_action(
        act.SpawnCommandInNewWindow {
            args = { 'nvim', name },
        },
        pane
    )

    -- Wait "enough" time for vim to read the file before we remove it.
    -- The window creation and process spawn are asynchronous wrt. running
    -- this script and are not awaitable, so we just pick a number.
    --
    -- Note: We don't strictly need to remove this file, but it is nice
    -- to avoid cluttering up the temporary directory.
    wezterm.sleep_ms(1000)
    os.remove(name)
end)

config.keys = {
    bind_if(is_outside_vim, 'UpArrow', 'SHIFT', act.ScrollToPrompt(-1)),
    bind_if(is_outside_vim, 'DownArrow', 'SHIFT', act.ScrollToPrompt(1)),
    bind_if(is_outside_vim, 'h', 'ALT', act.ActivatePaneDirection('Left')),
    bind_if(is_outside_vim, 'l', 'ALT', act.ActivatePaneDirection('Right')),

    { key = 'o', mods = "ALT",       action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },
    { key = 'w', mods = "ALT",       action = act.CloseCurrentPane({ confirm = true }) },
    { key = "h", mods = "ALT|SHIFT", action = act.AdjustPaneSize { "Left", 10 } },
    { key = "l", mods = "ALT|SHIFT", action = act.AdjustPaneSize { "Right", 10 } },
    { key = "t", mods = "ALT|SHIFT", action = act.EmitEvent('trigger-vim-with-scrollback') },
}
return config
