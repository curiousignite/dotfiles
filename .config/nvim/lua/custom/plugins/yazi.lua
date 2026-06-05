---@type LazySpec
return {
  'mikavilpas/yazi.nvim',
  version = '*', -- use the latest stable version
  event = 'VeryLazy',
  dependencies = {
    { 'nvim-lua/plenary.nvim', lazy = true },
  },
  keys = {
    -- 👇 in this section, choose your own keymappings!
    {
      '-',
      mode = { 'n', 'v' },
      '<cmd>Yazi<cr>',
      desc = 'Open yazi at the current file',
    },
    {
      -- Open in the current working directory
      '<leader>cw',
      '<cmd>Yazi cwd<cr>',
      desc = "Open the file manager in nvim's working directory",
    },
    {
      '<c-up>',
      '<cmd>Yazi toggle<cr>',
      desc = 'Resume the last yazi session',
    },
  },
  ---@type YaziConfig | {}
  opts = {
    open_for_directories = true,
    keymaps = {
      show_help = '<f1>',
    },
    -- 👇 Intercept the file choice on Enter
    open_file_function = function(chosen_file, config, state)
      -- Check if the selected file has a .pdf extension (case-insensitive)
      if chosen_file:match '%.[pP][dD][fF]$' then
        -- Execute zathura in the background detached from Neovim
        vim.fn.jobstart({ 'zathura', chosen_file }, { detach = true })
      else
        -- Fallback to the default yazi.nvim behavior for all other text files
        vim.cmd("edit " .. vim.fn.fnameescape(chosen_file))
      end
    end,
  },
  -- 👇 if you use `open_for_directories=true`, this is recommended
  init = function()
    -- mark netrw as loaded so it's not loaded at all.
    --
    -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
    vim.g.loaded_netrwPlugin = 1
  end,
}
