-- This file configures nvim-lspconfig and its integration with blink.cmp.
return {
  'neovim/nvim-lspconfig',
  dependencies = { 'saghen/blink.cmp' },
  config = function()
    -- Get the lsp capabilities from blink.cmp
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    -- Configure lua_ls
    vim.lsp.config('lua_ls', {
      capabilities = capabilities,
    })

    -- Configure tsserver
    vim.lsp.config('tsserver', {
      capabilities = capabilities,
    })
  end,
}
