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
    -- {
    --     "folke/noice.nvim",
    --     event = "VeryLazy",
    --     enabled = true,
    --     lazy = true,
    --     opts = function(_, opts)
    --         table.insert(opts.routes, {
    --             filter = {
    --                 event = "notify",
    --                 find = "No information available",
    --             },
    --             opts = { skip = true },
    --         })
    --         opts.presets.lsp_doc_border = true
    --     end,
    --     dependencies = {
    --         "MunifTanjim/nui.nvim",
    --         "rcarriga/nvim-notify",
    --     },
    --     keys = {
    --         {
    --             "<S-Enter>",
    --             function()
    --                 require("noice").redirect(vim.fn.getcmdline())
    --             end,
    --             mode = "c",
    --             desc = "Redirect Cmdline",
    --         },
    --         {
    --             "<leader>snl",
    --             function()
    --                 require("noice").cmd("last")
    --             end,
    --             desc = "Noice Last Message",
    --         },
    --         {
    --             "<leader>snh",
    --             function()
    --                 require("noice").cmd("history")
    --             end,
    --             desc = "Noice History",
    --         },
    --         {
    --             "<leader>sna",
    --             function()
    --                 require("noice").cmd("all")
    --             end,
    --             desc = "Noice All",
    --         },
    --         {
    --             "<c-f>",
    --             function()
    --                 if not require("noice.lsp").scroll(4) then
    --                     return "<c-f>"
    --                 end
    --             end,
    --             silent = true,
    --             expr = true,
    --             desc = "Scroll forward",
    --             mode = { "i", "n", "s" },
    --         },
    --         {
    --             "<c-b>",
    --             function()
    --                 if not require("noice.lsp").scroll(-4) then
    --                     return "<c-b>"
    --                 end
    --             end,
    --             silent = true,
    --             expr = true,
    --             desc = "Scroll backward",
    --             mode = { "i", "n", "s" },
    --         },
    --     },
    -- },
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
                function()
                    local status = require("ollama").status()

                    if status == "IDLE" then
                        return "󱙺" -- nf-md-robot-outline
                    elseif status == "WORKING" then
                        return "󰚩" -- nf-md-robot
                    end
                end,
                cond = function()
                    return package.loaded["ollama"] and require("ollama").status() ~= nil
                end,
            })
        end,
    },
    --Neovim QT settings
    { "equalsraf/neovim-gui-shim" },
    -- logo

    -- ColorMyPencils()
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
