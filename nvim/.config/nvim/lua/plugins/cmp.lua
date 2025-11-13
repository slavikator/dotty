-- lua/plugins/cmp.lua
return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
    'L3MON4D3/LuaSnip',
  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'

    cmp.setup({
      snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
      }),
      preselect = cmp.PreselectMode.None,
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
      }),
      window = {
        completion = cmp.config.window.bordered({
          border = 'double',
          zindex = 1001,
          col_offset = 2,
          scrolloff = 2,
          winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None',
        }),
        documentation = cmp.config.window.bordered({
          border = 'double',
          zindex = 1000,
          col_offset = 2,
          scrolloff = 2,
          winhighlight = 'Normal:CmpDoc,FloatBorder:CmpBorder',
        }),
      },

      formatting = {
        fields = { 'abbr', 'kind', 'menu' },
        format = function(entry, vim_item)
          vim_item.abbr = ' ' .. vim_item.abbr .. ' ' -- add left/right padding
          return vim_item
        end,
      },
    })
  end,
}
