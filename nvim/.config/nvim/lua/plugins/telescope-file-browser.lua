return {
  'nvim-telescope/telescope-file-browser.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope = require 'telescope'
    local fb_actions = require('telescope').extensions.file_browser.actions

    telescope.setup({
      extensions = {
        file_browser = {
          sorting_strategy = 'ascending',
          layout_config = { prompt_position = 'top' },
          -- disables netrw and use telescope-file-browser instead
          hijack_netrw = true,
          mappings = {
            ['i'] = {
              ['<C-w>'] = function() vim.cmd 'normal vbd' end,
            },
            ['n'] = {
              ['N'] = fb_actions.create,
              ['h'] = fb_actions.goto_parent_dir,
              ['/'] = function() telescope.extensions.file_browser.actions.search_live_grep() end,
            },
          },
        },
      },
    })
    -- Enable file_browser extension
    telescope.load_extension 'file_browser'

    -- Keymaps for file_browser
    vim.keymap.set('n', '<leader>fb', '<cmd>Telescope file_browser<cr>', { desc = 'File Browser' })
    vim.keymap.set(
      'n',
      '<leader>fB',
      '<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>',
      { desc = 'File Browser (current file dir)' }
    )
  end,
}
