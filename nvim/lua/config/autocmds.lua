-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
-- For conceallevel for json files
local autocmd = vim.api.nvim_create_autocmd
local vim = vim
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


-- autocmd("LspAttach", {
--     callback = function(e)
--         vim.keymap.set("n", "gd", function()
--             vim.lsp.buf.definition()
--         end, { buffer = e.buf, desc = "Definition" })
--         vim.keymap.set("n", "K", function()
--             vim.lsp.buf.hover()
--         end, { buffer = e.buf, desc = "Hover" })
--         vim.keymap.set("n", "<leader>vws", function()
--             vim.lsp.buf.workspace_symbol()
--         end, { buffer = e.buf, desc = "Workspace Symbol" })
--         vim.keymap.set("n", "<leader>vd", function()
--             vim.diagnostic.open_float()
--         end, { buffer = e.buf, desc = "Open Float" })
--         vim.keymap.set("n", "<leader>vca", function()
--             vim.lsp.buf.code_action()
--         end, { buffer = e.buf, desc = "Code Action" })
--         vim.keymap.set("n", "<leader>vrr", function()
--             vim.lsp.buf.references()
--         end, { buffer = e.buf, desc = "References" })
--         vim.keymap.set("n", "<leader>vrn", function()
--             vim.lsp.buf.rename()
--         end, { buffer = e.buf, desc = "Rename" })
--         vim.keymap.set("i", "<C-h>", function()
--             vim.lsp.buf.signature_help()
--         end, { buffer = e.buf, desc = "Signature Help" })
--         vim.keymap.set("n", "[d", function()
--             vim.diagnostic.goto_next()
--         end, { buffer = e.buf, desc = "GOGO Next" })
--         vim.keymap.set("n", "]d", function()
--             vim.diagnostic.goto_prev()
--         end, { buffer = e.buf, desc = "GOTO Prev" })
--     end,
-- })
