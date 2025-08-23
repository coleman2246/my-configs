return {
  {
    'RaafatTurki/hex.nvim',
    config = function()
      require('hex').setup({
        -- Add any plugin-specific options here if needed
      })
      vim.api.nvim_set_keymap('n', '<leader>hx', ':HexToggle<CR>', { noremap = true, silent = true })
    end,
  },
}

