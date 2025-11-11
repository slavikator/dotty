-- lua/plugins/treesitter-context.lua
return {
  -- Context lines for the current code block
  'nvim-treesitter/nvim-treesitter-context',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('treesitter-context').setup({
      enable = true, -- Enable this plugin
      max_lines = 3, -- Max number of lines for the context window
      trim_scope = 'outer', -- Trim outer context when max_lines is exceeded
      mode = 'cursor', -- Show context for where the cursor is
      multiline_threshold = 20, -- Max lines per context block
      zindex = 20, -- Z-index of the context window
    })
  end,
}