-- lua/plugins/neo-tree.lua
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function()
    -- Unless you are still migrating, remove the deprecated commands
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

    require("neo-tree").setup({
      close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      window = {
        position = "left",
        width = 30,
        mappings = {
          ["a"] = "add", -- "add" will prompt for a new file or directory
          ["<leader>e"] = "close_window",
        },
      },
      filesystem = {
        filtered_items = {
          visible = true, -- This will show dotfiles in the tree
          hide_dotfiles = false,
          hide_gitignored = true,
        },
        follow_current_file = true, -- Focus the file in the tree when changing buffers.
        group_empty_dirs = true, -- Group empty directories when expanding.
      },
    })

    -- Keymap to toggle neo-tree
    vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>', { desc = 'Toggle file explorer' })
  end,
}
