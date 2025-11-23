return {
  "catppuccin/nvim",
  lazy = true,
  name = "catppuccin",
  opts = {
    transparent_background = true,
    float = {transparent = true},
    highlight_overrides = {
      all = {
        CursorLine = { bg = "none" },
      },
    },
  },
}
