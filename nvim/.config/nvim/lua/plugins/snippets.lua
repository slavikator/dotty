-- This file configures the LuaSnip snippet engine.
-- It sets up snippet history, keymaps for expanding and jumping between snippets,
-- and loads snippets from vscode-style snippet packs.

return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      local ls = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      ls.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
      })

      -- Without expr -> no bug
      vim.keymap.set({ "i", "s" }, "<Tab>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
        end
      end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true })
    end,
  },
}
