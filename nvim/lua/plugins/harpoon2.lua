return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = true,
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup({})
    end
}
