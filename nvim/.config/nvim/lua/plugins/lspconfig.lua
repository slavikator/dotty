-- lua/plugins/lspconfig.lua
return {
  'neovim/nvim-lspconfig',
  dependencies = { 'saghen/blink.cmp' },
  config = function()
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    -- Lua LSP
    vim.lsp.config('lua_ls', {
      capabilities = capabilities,
    })
    vim.lsp.enable('lua_ls')

    -- TypeScript / TSX / JSX LSP
    vim.lsp.config('tsserver', {
      capabilities = capabilities,
      filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
      settings = {
        javascript = {
          preferences = {
            jsxBracketSameLine = true,
          },
        },
        typescript = {
          preferences = {
            jsxBracketSameLine = true,
          },
        },
        jsx = 'react-jsx',
      },
    })
    vim.lsp.enable('tsserver')
  end,
}
