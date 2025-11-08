-- This file configures the blink.cmp completion plugin.
return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets', -- optional
    "L3MON4D3/LuaSnip", -- snippet engine
  },
  version = '1.*', -- use a release tag for pre-built binaries
  opts = {
    keymap = { preset = 'default' },
    appearance = { nerd_font_variant = 'mono' },
    completion = { documentation = { auto_show = false } },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
}
