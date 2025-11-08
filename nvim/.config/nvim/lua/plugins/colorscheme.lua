-- This file configures the colorscheme for Neovim.
-- It uses the '0x96f.nvim' plugin.

return {
  "filipjanevski/0x96f.nvim",
  priority = 1000,
  config = function()
    require("0x96f").setup()
    vim.cmd.colorscheme("0x96f")
  end,
}
