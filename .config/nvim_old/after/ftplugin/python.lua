vim.bo.expandtab = true
vim.bo.autoindent = true
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.textwidth = 80

-- Set the indent after opening parenthesis
vim.g.pyindent_open_paren = vim.bo.shiftwidth

-- Automatically make the current string an f-string when typing `{`.
vim.api.nvim_create_autocmd("InsertCharPre", {
  pattern = { "*.py" },
  group = vim.api.nvim_create_augroup("py-fstring", { clear = true }),
  callback = function(params)
    if vim.v.char ~= "{" then return end

    local node = vim.treesitter.get_node({})

    if not node then return end

    if node:type() ~= "string" then node = node:parent() end

    if not node or node:type() ~= "string" then return end
    local row, col, _, _ = vim.treesitter.get_node_range(node)
    local first_char = vim.api.nvim_buf_get_text(params.buf, row, col, row, col + 1, {})[1]
    if first_char == "f" or first_char == "r" then return end

    vim.api.nvim_input("<Esc>m'" .. row + 1 .. "gg" .. col + 1 .. "|if<esc>`'la")
  end,
})

-- ------------------------------------------------------------------------
-- | MiniAI
-- ------------------------------------------------------------------------

local spec_treesitter = require("mini.ai").gen_spec.treesitter
vim.b.miniai_config = {
  custom_textobjects = {
    t = spec_treesitter({ a = "@annotation.outer", i = "@annotation.outer" }),
  },
}

-- ------------------------------------------------------------------------
-- | Keymaps
-- ------------------------------------------------------------------------

vim.keymap.set(
  { "n", "x" },
  "<leader>x",
  [[:!python3 %<CR>]],
  { buffer = true, desc = "Run the file or region through the interpreter" }
)
