return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  config = function()
    vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]

    require('neo-tree').setup({
      close_if_last_window = true,
      popup_border_style = 'rounded',
      enable_git_status = true,
      enable_diagnostics = true,

      window = {
        position = 'right',
        width = 40,
        mappings = {
          ['a'] = 'add', -- create a new file or directory
        },
      },

      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
        follow_current_file = true,
        group_empty_dirs = true,
      },

      event_handlers = {
        -- Close Neo-tree after opening a file
        {
          event = 'file_opened',
          handler = function() require('neo-tree.command').execute({ action = 'close' }) end,
        },
        -- Open newly created file in the main window and close Neo-tree
        {
          event = 'file_added',
          handler = function(file_path)
            vim.defer_fn(function()
              vim.cmd('edit ' .. vim.fn.fnameescape(file_path))
              require('neo-tree.command').execute({ action = 'close' })
            end, 10)
          end,
        },
      },
    })

    vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>', { desc = 'Toggle file explorer' })
  end,
}
