return {
    -- ref: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
    ssh_domains = {
        {
            name = 'berke',
            remote_address = 'berkeerbagci.online',
            username = 'berkeerbagci',
        },

    },

    -- ref: https://wezfurlong.org/wezterm/multiplexing.html#unix-domains
    unix_domains = {},

    -- ref: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
    -- wsl_domains = {
    --    {
    --       name = 'WSL:Arch',
    --       distribution = 'Arch',
    --       username = 'berke',
    --       default_cwd = '/home/berke',
    --       default_prog = { 'zsh', '-l' },
    --    },
    -- },
}
