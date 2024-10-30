return {
    {
        "echasnovski/mini.surround",
        lazy = true,
        event = "VeryLazy",
        version = "*",
    },
    {
        "echasnovski/mini.ai",
        lazy = true,
        event = "VeryLazy",
        version = "*",
    },
    {
        "echasnovski/mini.icons",
        lazy = true,
        event = "VeryLazy",
        version = "*",
    },

    -- bufferline
    {
        "akinsho/bufferline.nvim",
        keys = {
            { "<Tab>",   "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
            { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
        },
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                mode = "tabs",
                show_buffer_close_icons = false,
                show_close_icon = false,
                after = "catppuccin",
                config = function()
                    require("bufferline").setup({
                        print(require("catppuccin.groups.integrations.bufferline").get()),
                    })
                end,
            },
        },
    },
    -- statusline
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        optional = true,
        opts = function(_, opts)
            table.insert(opts.sections.lualine_x, {
            })
        end,
    },
    --Neovim QT settings
    { "equalsraf/neovim-gui-shim" },
    -- logo
    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        opts = function(_, opts)
            local logo =
            [[
 ,,                                                          ,,                                   ,, ⠀
*MM                       `7MM                              *MM                                   db ⠀
 MM                         MM                               MM                                      ⠀
 MM,dMMb.   .gP"Ya `7Mb,od8 MM  ,MP'.gP"Ya   .gP"Ya `7Mb,od8 MM,dMMb.   ,6"Yb.  .P"Ybmmm ,p6"bo `7MM ⠀
 MM    `Mb ,M'   Yb  MM' "' MM ;Y  ,M'   Yb ,M'   Yb  MM' "' MM    `Mb 8)   MM :MI  I8  6M'  OO   MM ⠀
 MM     M8 8M""""""  MM     MM;Mm  8M"""""" 8M""""""  MM     MM     M8  ,pm9MM  WmmmP"  8M        MM ⠀
 MM.   ,M9 YM.    ,  MM     MM `Mb.YM.    , YM.    ,  MM     MM.   ,M9 8M   MM 8M       YM.    ,  MM ⠀
 P^YbmdP'   `Mbmmd'.JMML. .JMML. YA.`Mbmmd'  `Mbmmd'.JMML.   P^YbmdP'  `Moo9^Yo.YMMMMMb  YMbmd' .JMML⠀
                                                                              6'     dP             ⠀
                                                                              Ybmmmd'               ⠀]]
            logo = string.rep("\n", 9) .. logo .. "\n\n"
            opts.config.header = vim.split(logo, "\n")
        end,
    },
}
