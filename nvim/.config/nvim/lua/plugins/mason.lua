return {
  -- Mason core plugin
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason integration with lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        automatic_installation = true,
      })
    end,
  },

  -- Automatic installation of CLI tools
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
	  "stylua",
          "prettier",
          "prettierd",
          "eslint_d",
          "typescript-language-server",
        },
        run_on_start = true,
        start_delay = 2000,
        auto_update = false,
      })
    end,
  },
}

