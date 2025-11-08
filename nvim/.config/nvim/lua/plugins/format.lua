-- This file configures the conform.nvim plugin for code formatting.
-- It sets up formatters for different file types and a keymap to trigger formatting.

return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      json = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      markdown = { "prettier" },
    },
    format_on_save = false,
  },
  init = function()
    vim.keymap.set({"n", "v"}, "<leader>f", function()
      require("conform").format({async = true, lsp_fallback = true})
    end, {desc = "Format"})
  end,
}

