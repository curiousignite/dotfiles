local wezterm = require('wezterm')
local platform = require('utils.platform')()
local backdrops = require('utils.backdrops')
local act = wezterm.action

local mod = {}

if platform.is_mac then
    mod.SUPER = 'SUPER'
    mod.SUPER_REV = 'SUPER|CTRL'
elseif platform.is_win or platform.is_linux then
    mod.SUPER = 'ALT' -- to not conflict with Windows key shortcuts
    mod.SUPER_REV = 'ALT|CTRL'
end

local function isViProcess(pane)
    -- get_foreground_process_name On Linux, macOS and Windows,
    -- the process can be queried to determine this path. Other operating systems
    -- (notably, FreeBSD and other unix systems) are not currently supported
    return pane:get_foreground_process_name():find('n?vim') ~= nil or pane:get_title():find("n?vim") ~= nil or pane:get_title():find("node") ~= nil

end

local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
    if isViProcess(pane) then
        window:perform_action(
        -- This should match the keybinds you set in Neovim.
            act.SendKey({ key = vim_direction, mods = 'CTRL' }),
            pane
        )
    else
        window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
    end
end
wezterm.on('ActivatePaneDirection-right', function(window, pane)
    conditionalActivatePane(window, pane, 'Right', 'l')
end)
wezterm.on('ActivatePaneDirection-left', function(window, pane)
    conditionalActivatePane(window, pane, 'Left', 'h')
end)
wezterm.on('ActivatePaneDirection-up', function(window, pane)
    conditionalActivatePane(window, pane, 'Up', 'k')
end)
wezterm.on('ActivatePaneDirection-down', function(window, pane)
    conditionalActivatePane(window, pane, 'Down', 'j')
end)


local keys = {
    { key = 'ğ', mods = 'CTRL',         action = act.ActivatePaneDirection("Prev") },
    { key = 'ü', mods = 'CTRL',         action = act.ActivatePaneDirection("Next") },

    { key = '"', mods = "CTRL",         action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },
    { key = '-', mods = "CTRL",         action = act.SplitVertical({ domain = 'CurrentPaneDomain' }) },
    { key = 'q', mods = "CTRL | SHIFT", action = act.CloseCurrentPane { confirm = false } },
    { key = 'w', mods = "CTRL | SHIFT", action = act.CloseCurrentTab({ confirm = false }) },
    { key = "h", mods = "ALT|SHIFT",    action = act.AdjustPaneSize { "Left", 10 } },
    { key = "l", mods = "ALT|SHIFT",    action = act.AdjustPaneSize { "Right", 10 } },
    { key = "t", mods = "ALT|SHIFT",    action = act.EmitEvent('trigger-vim-with-scrollback') },

    -- movement
    { key = 'h', mods = 'CTRL',         action = act.EmitEvent('ActivatePaneDirection-left') },
    { key = 'j', mods = 'CTRL',         action = act.EmitEvent('ActivatePaneDirection-down') },
    { key = 'k', mods = 'CTRL',         action = act.EmitEvent('ActivatePaneDirection-up') },
    { key = 'l', mods = 'CTRL',         action = act.EmitEvent('ActivatePaneDirection-right') },
    -- search
    { key = 'f', mods = 'CTRL|SHIFT',   action = act.Search({ CaseInSensitiveString = '' }) },
    {
        key = 'p',
        mods = "CTRL",
        action = act.QuickSelectArgs {
            label = "open url",
            patterns = {
                '\\((https?://\\S+)\\)',
                '\\[(https?://\\S+)\\]',
                '\\{(https?://\\S+)\\}',
                '<(https?://\\S+)>',
                '\\bhttps?://\\S+[)/a-zA-Z0-9-]+'

            },
            action = wezterm.action_callback(function(win, pane)
                local url = win:get_selection_text_for_pane(pane)
                wezterm.log_info('opening: ' .. url)
                wezterm.open_with(url)
            end)


        },
    },
    -- misc/useful --
    { key = 'F1',  mods = 'NONE',       action = 'ActivateCopyMode' },
    { key = 'F2',  mods = 'NONE',       action = act.ActivateCommandPalette },
    { key = 'F3',  mods = 'NONE',       action = act.ShowLauncher },
    { key = 'F4',  mods = 'NONE',       action = act.ShowLauncherArgs({ flags = 'FUZZY|TABS' }) },
    -- {
    --     key = 'F5',
    --     mods = 'NONE',
    --     action = act.ShowLauncherArgs({ flags = 'FUZZY|WORKSPACES' }),
    -- },
    { key = 'F11', mods = 'NONE',       action = act.ToggleFullScreen },

    -- copy/paste --
    { key = 'c',   mods = 'CTRL|SHIFT', action = act.CopyTo('Clipboard') },
    { key = 'v',   mods = 'CTRL|SHIFT', action = act.PasteFrom('Clipboard') },
    -- background controls --
    {
        key = [[/]],
        mods = mod.SUPER,
        action = wezterm.action_callback(function(window, _pane)
            backdrops:random(window)
        end),
    },
    {
        key = [[,]],
        mods = mod.SUPER,
        action = wezterm.action_callback(function(window, _pane)
            backdrops:cycle_back(window)
        end),
    },
    {
        key = [[.]],
        mods = mod.SUPER,
        action = wezterm.action_callback(function(window, _pane)
            backdrops:cycle_forward(window)
        end),
    },
    {
        key = [[/]],
        mods = mod.SUPER_REV,
        action = act.InputSelector({
            title = 'Select Background',
            choices = backdrops:choices(),
            fuzzy = true,
            fuzzy_description = 'Select Background: ',
            action = wezterm.action_callback(function(window, _pane, idx)
                ---@diagnostic disable-next-line: param-type-mismatch
                backdrops:set_img(window, tonumber(idx))
            end),
        }),
    },

    { key = '1',   mods = 'CTRL',         action = act.ActivateTab(0) },
    { key = '2',   mods = 'CTRL',         action = act.ActivateTab(1) },
    { key = '3',   mods = 'CTRL',         action = act.ActivateTab(2) },
    { key = '4',   mods = 'CTRL',         action = act.ActivateTab(3) },
    { key = '5',   mods = 'CTRL',         action = act.ActivateTab(4) },
    { key = '6',   mods = 'CTRL',         action = act.ActivateTab(5) },
    { key = '7',   mods = 'CTRL',         action = act.ActivateTab(6) },
    { key = '8',   mods = 'CTRL',         action = act.ActivateTab(7) },
    { key = '9',   mods = 'CTRL',         action = act.ActivateTab(8) },
    { key = '0',   mods = 'CTRL',         action = act.ActivateTab(9) },
    { key = '*',   mods = 'CTRL',         action = act.ActivateTab(10) },

    { key = 't',   mods = 'CTRL',         action = act.SpawnTab('DefaultDomain') },
    -- tabs: navigation
    { key = 'Tab', mods = 'SHIFT | CTRL', action = act.ActivateTabRelative(-1) },
    { key = 'Tab', mods = 'CTRL',         action = act.ActivateTabRelative(1) },
    -- key_tables activation
    { key = 'r',   mods = 'LEADER',       action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false }, },
    { key = 'f',   mods = 'LEADER',       action = act.ActivateKeyTable { name = 'resize_font', one_shot = false }, },
}
-- stylua: ignore
local key_tables = {
    resize_font = {
        { key = 'k', action = act.IncreaseFontSize },
        { key = 'j', action = act.DecreaseFontSize },
        { key = 'r', action = act.ResetFontSize },
    },
    resize_pane = {
        { key = 'k', action = act.AdjustPaneSize({ 'Up', 1 }) },
        { key = 'j', action = act.AdjustPaneSize({ 'Down', 1 }) },
        { key = 'h', action = act.AdjustPaneSize({ 'Left', 1 }) },
        { key = 'l', action = act.AdjustPaneSize({ 'Right', 1 }) },
    },
}
for k, _ in pairs(key_tables) do
    table.insert(key_tables[k], { key = "Escape", action = "PopKeyTable" })
    table.insert(key_tables[k], { key = "q", action = "PopKeyTable" })
    table.insert(
        key_tables[k],
        { key = "c", mods = "CTRL", action = "PopKeyTable" }
    )
end
local mouse_bindings = {
    -- Ctrl-click will open the link under the mouse cursor
    {
        event = { Up = { streak = 1, button = 'Left' } },
        mods = 'CTRL',
        action = act.OpenLinkAtMouseCursor,
    },
}

return {
    disable_default_key_bindings = true,
    leader = { key = 'Space', mods = mod.SUPER_REV, timeout_milliseconds = math.maxinteger },
    keys = keys,
    key_tables = key_tables,
    mouse_bindings = mouse_bindings,
}
