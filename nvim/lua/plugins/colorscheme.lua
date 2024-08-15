return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,

        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                transparent_background = true,
                styles = {
                    sidebars = "transparent",
                    floats = "transparent",
                },
                term_colors = true,
                dim_inactive = {
                    enabled = true,
                    shade = "dark",
                    percentage = 0.15,
                },
                integrations = {
                    notify = true,
                    noice = true,
                    fidget = true,
                    harpoon = true,
                    mason = true,
                    which_key = true,
                    lsp_trouble = true,
                },
            })
        end,
    },
}
