-- Pull in the wezterm API
-- This will hold the configuration.
local wezterm = require 'wezterm'
local io = require 'io'
local os = require 'os'
local act = wezterm.action
local config = wezterm.config_builder()
config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font 'Hack Nerd Font Mono'
config.window_background_opacity = 0.8
config.text_background_opacity = 1.0
config.enable_scroll_bar = false
config.font_size = 14
config.line_height = 1
config.use_fancy_tab_bar = false
config.adjust_window_size_when_changing_font_size = false
config.inactive_pane_hsb = { saturation = 0.8, brightness = 0.7 }
-- config.front_end = 'OpenGL'
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

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
            win:perform_action(wezterm.action.SendKey({ key = key, mods = mods }), pane)
        end
    end
    return { key = key, mods = mods, action = wezterm.action_callback(callback) }
end

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    config.default_prog = { 'C:\\Program Files\\PowerShell\\7\\pwsh.exe' }
    -- config.win32_system_backdrop = 'Acrylic'
    -- config.win32_system_backdrop = 'Tabbed'
else

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
    bind_if(is_outside_vim, 'UpArrow', 'SHIFT', wezterm.action.ScrollToPrompt(-1)),
    bind_if(is_outside_vim, 'DownArrow', 'SHIFT', wezterm.action.ScrollToPrompt(1)),
    bind_if(is_outside_vim, 'h', 'ALT', wezterm.action.ActivatePaneDirection('Left')),
    bind_if(is_outside_vim, 'l', 'ALT', wezterm.action.ActivatePaneDirection('Right')),

    { key = 'o', mods = "ALT",       action = wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },
    { key = 'w', mods = "ALT",       action = wezterm.action.CloseCurrentPane({ confirm = true }) },
    { key = "h", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize { "Left", 10 } },
    { key = "l", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize { "Right", 10 } },
    { key = "t", mods = "ALT|SHIFT", action = wezterm.action.EmitEvent('trigger-vim-with-scrollback') },
}
return config
