return {
  "olrtg/nvim-emmet",
  ft = { "html", "css", "javascriptreact", "typescriptreact", "vue", "svelte", "astro" }, -- Adjust filetypes as needed
  config = function()
    vim.keymap.set({ "n", "v" }, "<leader>xe", require("nvim-emmet").wrap_with_abbreviation)

    -- Setup emmet-language-server
    local lspconfig = require("lspconfig")
    lspconfig.emmet_language_server.setup({
      -- You can add custom settings here if needed
      -- For example, to enable Emmet in specific filetypes not automatically detected:
      -- capabilities = capabilities,
      -- on_attach = on_attach,
      filetypes = {
        "html",
        "css",
        "javascriptreact",
        "typescriptreact",
        "vue",
        "svelte",
        "astro",
        "php", -- Example: add php if you want Emmet in PHP files
      },
    })
  end,
}