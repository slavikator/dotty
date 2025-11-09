-- lua/plugins/mason.lua
return {
  {
    'williamboman/mason.nvim',
    config = function() require('mason').setup() end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      require('mason-lspconfig').setup({
        automatic_installation = true,
        -- Додаємо обробник для eslint
        handlers = {
          -- Обробник за замовчуванням
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,
          -- Спеціальний обробник для eslint
          ['eslint'] = function()
            require('lspconfig').eslint.setup({
              -- Додаткові налаштування для eslint, якщо потрібно
              -- Наприклад, для автоматичного виправлення при збереженні
              -- on_attach = function(client, bufnr)
              --   vim.api.nvim_create_autocmd("BufWritePre", {
              --     buffer = bufnr,
              --     callback = function()
              --       vim.lsp.buf.format({ async = true })
              --     end,
              --   })
              -- end,
            })
          end,
        },
      })
    end,
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      require('mason-tool-installer').setup({
        ensure_installed = {
          'stylua',
          'prettier',
          'prettierd',
          'eslint_d',
          'typescript-language-server',
        },
        run_on_start = true,
        start_delay = 2000,
        auto_update = false,
      })
    end,
  },
}
