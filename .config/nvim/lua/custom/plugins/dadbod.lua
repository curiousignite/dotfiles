return {
  'tpope/vim-dadbod',
  dependencies = {
    'kristijanhusak/vim-dadbod-ui',
    'kristijanhusak/vim-dadbod-completion',
  },
  config = function()
    vim.g.db_ui_save_location = vim.fn.stdpath 'config' .. '/db_ui'

    vim.keymap.set('n', '<leader>du', ':DBUIToggle<CR>', { desc = 'Toggle DB UI' })
    vim.keymap.set('n', '<leader>df', ':DBUIFindBuffer<CR>', { desc = 'Find DB UI Buffer' })
    vim.keymap.set('n', '<leader>dr', ':DBUIRenameBuffer<CR>', { desc = 'Rename DB UI Buffer' })
    vim.keymap.set('n', '<leader>dl', ':DBUILastQueryInfo<CR>', { desc = 'Last Query Info' })

    -- Auto-open DB UI for .db files
    vim.api.nvim_create_autocmd('BufReadCmd', {
      pattern = '*.db',
      callback = function(args)
        local path = vim.fn.fnamemodify(args.file, ':p')
        -- Use double quotes to wrap the URL and prevent colon parsing issues
        vim.cmd('DBUIAddConnection "sqlite:' .. path .. '"')
        vim.cmd('DBUIToggle')
      end,
    })

    -- Auto-completion for SQL files
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'sql', 'mysql', 'plsql' },
      callback = function()
        require('cmp').setup.buffer { sources = { { name = 'vim-dadbod-completion' } } }
      end,
    })
  end,
}
