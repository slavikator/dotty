return {
  "Mofiqul/vscode.nvim",
  name = "vscode",
  priority = 1000,
  config = function()
    require("vscode").setup({
      -- параметри теми
      transparent = false, -- або true, якщо хочеш прозорий фон
      italic_comments = true,
      underline_links = true,
      disable_nvimtree_bg = true,
    })
    require("vscode").load()
  end,
}

