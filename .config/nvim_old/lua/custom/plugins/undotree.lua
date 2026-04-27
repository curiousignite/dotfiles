return {
  "mbbill/undotree",
  config = function()
    vim.keymap.set("n", "<F5>", ":UndotreeToggle<CR>", { desc = "Undo tree toggle" })
  end,
}
