return {
  -- tools installed by Mason
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "actionlint",            -- GitHub Actions workflows
        "shellcheck",            -- shell scripts, also used by actionlint for run: steps
        "bash-language-server",  -- az CLI scripts (.sh)
        "shfmt",                 -- shell formatting
      },
    },
  },

  -- run actionlint only on GitHub workflow files
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        yaml = { "actionlint" },
      },
      linters = {
        actionlint = {
          condition = function(ctx)
            return ctx.filename:find("%.github/workflows/") ~= nil
          end,
        },
      },
    },
  },
}
