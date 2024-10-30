-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
-- For conceallevel for json files
local autocmd = vim.api.nvim_create_autocmd
autocmd("FileType", {
    pattern = { "json", "jsonc", "lua" },
    callback = function()
        vim.wo.spell = false
        vim.wo.conceallevel = 0
    end
})
autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        vim.api.nvim_set_hl(0, "TabLine", { bg = "none" })
        vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none" })
        vim.api.nvim_set_hl(0, "TabLineSelect", { bg = "none" })
    end,
})
