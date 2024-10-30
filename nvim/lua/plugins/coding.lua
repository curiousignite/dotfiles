return {
    { "smjonas/inc-rename.nvim",  cmd = "IncRename", config = true, lazy = false },
    { "NvChad/nvim-colorizer.lua" },
    {
        "echasnovski/mini.surround",
        version = false,
        config = function()
            require("mini.surround").setup()
        end,
    },
    { -- Fuzzy Finder (files, lsp, etc)
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable("make") == 1
                end,
            },
            {
                "nvim-tree/nvim-web-devicons",
                enabled = vim.g.have_nerd_font
            },
            { "nvim-treesitter/nvim-treesitter" },
            { "nvim-telescope/telescope-ui-select.nvim" },
        },
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_ivy(),
                    },
                },
                defaults = {
                    file_ignore_patterns = {
                        ".jpg",
                        ".png",
                        "undodir/*",
                        ".stfolder/*",
                        ".stversions/*",
                        "*sync-conflict*",
                    },
                },
            })
        end,
    },
    { "tpope/vim-fugitive",     version = "*" },
    { "junegunn/vim-easy-align" },
}
