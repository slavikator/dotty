-- lua/plugins/cmp.lua
return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
    'L3MON4D3/LuaSnip',
    -- 'onsails/lspkind.nvim', -- Видалено
    -- 'kyazdani42/nvim-web-devicons', -- Видалено
    -- 'hrsh7th/cmp-nvim-lsp-signature', -- Видалено
  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    -- local lspkind = require 'lspkind' -- Видалено

    cmp.setup({
      snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select(true)
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select(false)
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),
      preselect = 'none',
      sources = cmp.config.sources({
        { name = 'nvim_lsp', priority = 100 },
        { name = 'luasnip', priority = 90 },
        { name = 'buffer', priority = 70, keyword_length = 3 },
        { name = 'path', priority = 60 },
      }),
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    })
  end,
}