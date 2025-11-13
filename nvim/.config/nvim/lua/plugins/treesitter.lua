-- lua/plugins/treesitter.lua
return {
  {
    -- Core Treesitter setup
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'javascript',
          'typescript',
          'tsx',
          'html',
          'css',
          'lua',
          'json',
          'bash',
        },
        highlight = { enable = true },
        indent = { enable = false },
      })
    end,
  },
}
