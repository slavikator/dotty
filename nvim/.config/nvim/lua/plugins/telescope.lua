-- lua/plugins/telescope.lua
return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-telescope/telescope-file-browser.nvim',
  },
  config = function()
    local telescope = require 'telescope'
    local actions = require 'telescope.actions'

    telescope.setup({
      defaults = {
        sorting_strategy = 'ascending',
        layout_config = { prompt_position = 'top' },
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
    })

    -- Add some useful keymaps
    vim.keymap.set(
      'n',
      '<leader>ff',
      '<cmd>Telescope find_files<cr>',
      { desc = 'Find Files (Telescope)' }
    )
    vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Live Grep' })
    vim.keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>', { desc = 'Recent Files' })
    vim.keymap.set('n', '<leader>b', '<cmd>Telescope buffers<cr>', { desc = 'Find Buffers' })
  end,
}
