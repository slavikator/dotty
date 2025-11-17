return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    local layout = require("plugins/lualine_custom.layout")
    table.insert(opts.sections.lualine_y, {
      layout.layout,
    })
  end,
}
