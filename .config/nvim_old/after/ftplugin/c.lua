vim.keymap.set("n", "<leader>x", function()
  local command         = ""
  local source_file     = vim.fn.expand("%:p")
  local executable_file = vim.fn.expand("%:p:r")

  command               = command .. vim.fn.expand("gcc ")
  command               = command .. " -Wall"
  command               = command .. " -Wextra"
  command               = command .. " -o "
  command               = command .. executable_file
  command               = command .. vim.fn.expand(" ")
  command               = command .. source_file
  command               = command .. vim.fn.expand(" && ")
  command               = command .. executable_file

  if command ~= "" then
    vim.cmd("10 split")
    vim.cmd("terminal " .. command)
    vim.cmd("startinsert")
    vim.cmd(":wincmd j")
  end
end, { desc = "Compile and run the current file" })
