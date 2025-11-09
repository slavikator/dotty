-- lua/plugins/autotag.lua
return {
  'windwp/nvim-ts-autotag',
  dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- Додано
  config = function()
    require('nvim-ts-autotag').setup({
      opts = {
        enable_close = true,
        enable_rename = true,
      }
    })
  end,
}