-- lua/plugins/alpha.lua
return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- Optional: for icons
  config = function ()
    local alpha = require'alpha'
    local dashboard = require'alpha.themes.dashboard'

    -- Header
    dashboard.section.header.val = {
      '███╗   ██╗ ██████╗ ██╗  ██╗ █████╗ ',
      '████╗  ██║██╔═══██╗██║  ██║██╔══██╗',
      '██╔██╗ ██║██║   ██║███████║███████║',
      '██║╚██╗██║██║   ██║██╔══██║██╔══██║',
      '██║ ╚████║╚██████╔╝██║  ██║██║  ██║',
      '╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝╚╝  ╚═╝',
    }
    dashboard.section.header.opts.hl = 'Type'

    -- Menu
    dashboard.section.buttons.val = {
      dashboard.button('n', '  New file', ':enew<CR>'),
      dashboard.button('f', '  Find file', '<cmd>Telescope find_files<CR>'),
      dashboard.button('r', '  Recent files', '<cmd>Telescope oldfiles<CR>'),
      dashboard.button('c', '  Config', ":lua require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config'), hidden = true })<CR>"),
      dashboard.button('g', '  Grep text', '<cmd>Telescope live_grep<CR>'),
      dashboard.button('l', '  Lazy', ':Lazy<CR>'),
      dashboard.button('m', '  Mason', ':Mason<CR>'),
      dashboard.button('q', '  Quit', ':q<CR>')
    }
    dashboard.section.buttons.opts.hl = 'Function'

    -- Footer
    dashboard.section.footer.val = 'dotty config'
    dashboard.section.footer.opts.hl = 'Comment'


    alpha.setup(dashboard.opts)
  end
}
