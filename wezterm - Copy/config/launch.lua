local platform = require('utils.platform')()

local options = {
    default_prog = {},
    launch_menu = {},
}

if platform.is_win then
    options.default_prog = { 'pwsh', '-NoLogo' }
    options.launch_menu = {
        { label = 'PowerShell Core', args = { 'pwsh', '-NoLogo' } },
    }
elseif platform.is_mac then
    options.default_prog = { '/opt/homebrew/bin/fish', '-l' }
    options.launch_menu = {
        { label = 'Zsh',  args = { 'zsh', '-l' } },
        { label = 'Bash', args = { 'bash', '-l' } },
        { label = 'Fish', args = { '/opt/homebrew/bin/fish', '-l' } },
    }
elseif platform.is_linux then
    options.default_prog = { 'fish', '-l' }
    options.launch_menu = {
        { label = 'Zsh',  args = { 'zsh', '-l' } },
        { label = 'Bash', args = { 'bash', '-l' } },
        { label = 'Fish', args = { 'fish', '-l' } },
    }
end

return options
