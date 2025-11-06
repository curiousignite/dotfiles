vim.keymap.set(
  { "n", "x" },
  "<leader>x",
  [[:!bash  %<CR>]],
  { buffer = true, desc = "Run the file or region through the interpreter" }
)
