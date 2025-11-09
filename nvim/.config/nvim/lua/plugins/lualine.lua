-- This file configures the lualine.nvim plugin for the statusline.
-- It defines the appearance and components of the statusline.

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local custom_fname = require('plugins/lualine_custom.filename')
    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
          refresh_time = 16, -- ~60fps
          events = {
            "WinEnter",
            "BufEnter",
            "BufWritePost",
            "SessionLoadPost",
            "FileChangedShellPost",
            "VimResized",
            "Filetype",
            "CursorMoved",
            "CursorMovedI",
            "ModeChanged",
          },
        },
      },
      sections = {
        lualine_a = {
          { 'mode' },
          {
            'lsp_status',
            icon = '', -- f013
            symbols = {
              -- Standard unicode symbols to cycle through for LSP progress:
              spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
              -- Standard unicode symbol for when LSP is done:
              done = '✓',
              -- Delimiter inserted between LSP names:
              separator = ' ',
            },
             -- List of LSP names to ignore (e.g., `null-ls`):
            ignore_lsp = {},
            -- Display the LSP name
            show_name = true,
          },
          {
            'diagnostics',
            sources = { 'nvim_diagnostic', 'coc' },
            sections = { 'error', 'warn', 'info', 'hint' },
            diagnostics_color = {
              error = 'DiagnosticError', -- Changes diagnostics' error color.
              warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
              info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
              hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
            },
            symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
            colored = true,           -- Displays diagnostics status in color if set to true.
            update_in_insert = false, -- Update diagnostics in insert mode.
            always_visible = false,   -- Show diagnostics even if there are none.
          }
        },
        lualine_b = { "branch", "diff" },
        lualine_c = {{custom_fname, path = 1}},
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = {
          "location",
          {
            'datetime',
            style = '%H:%M',
          },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {
        lualine_a = {
          {
            "buffers",
            show_filename_only = true,   -- Shows shortened relative path when set to false.
            hide_filename_extension = false,   -- Hide filename extension when set to true.
            show_modified_status = true, -- Shows indicator when the buffer is modified.
            mode = 2, -- 0: Shows buffer name
                -- 1: Shows buffer index
                -- 2: Shows buffer name + buffer index
                -- 3: Shows buffer number
                -- 4: Shows buffer name + buffer number
            buffers_color = {
              active = { bg = '#228B22', fg = '#ffffff' },     -- Color for active buffer.
              inactive = 'lualine_b_inactive', -- Color for inactive buffer.
            },
            symbols = {
              modified = ' ●',      -- Text to show when the buffer is modified
              alternate_file = '#', -- Text to show to identify the alternate file
              directory =  '',     -- Text to show when the buffer is a directory
            },
          },
        },
        lualine_c = {},
        lualine_z = { "tabs" },
      },
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    })
  end,
}
