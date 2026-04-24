-- vim.cmd('runtime! ftplugin/xxx.lua') -- inherit from xxx.lua
vim.wo.conceallevel = 2
vim.opt.textwidth = 80
vim.opt_local.formatoptions:append("ro")
vim.opt_local.comments = "b:*,b:-,b:+,n:>"

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

vim.keymap.set("i", "<CR>", function()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local before_cursor = line:sub(1, col)
  -- Recognize space, x, X, /, and - inside the brackets
  if before_cursor:match("^%s*[%-%*] %[[ xX/%-]%]") then
    -- Escape hatch: If there is no text after the checkbox, wipe the line
    if before_cursor:match("^%s*[%-%*] %[[ xX/%-]%]%s*$") then
      return t("<Esc>S")
    end
    return t("<CR>[ ] ")
  end
  -- Fallback: Standard enter behavior
  return t("<CR>")
end, { buffer = true, expr = true, desc = "Auto-continue markdown checkboxes" })

vim.keymap.set("n", "<leader>x", function()
  local line = vim.api.nvim_get_current_line()
  local prefix, state, suffix = line:match("^(%s*[%-%*] %[)([ xX/%-])(%].*)$")
  if prefix then
    local next_state = {
      [" "] = "x",
      ["/"] = " ",
      ["-"] = " ",
      ["x"] = " ",
      ["X"] = " "
    }
    local new_state = next_state[state] or " "
    local new_line = prefix .. new_state .. suffix
    vim.api.nvim_set_current_line(new_line)
  end
end, { buffer = true, desc = "Cycle Markdown Checkbox State" })
