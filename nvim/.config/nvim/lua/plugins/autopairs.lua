-- lua/plugins/autopairs.lua
return {
  'windwp/nvim-autopairs',
  event = "InsertEnter",
  config = function()
    require("nvim-autopairs").setup({
      check_ts = true, -- enable treesitter
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
      },
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      fast_wrap = {},
      map_cr = true,
      map_bs = true,
      map_c_h = false,
      map_c_w = false,
    })
  end,
}
