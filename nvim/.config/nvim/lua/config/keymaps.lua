-- Visual mode: paste over selection without yanking replaced text
vim.keymap.set('x', '<leader>p', [["_dP]])

-- Yank to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

-- Delete without yanking
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d')

-- Move selected lines up/down in visual mode
vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv') -- Move selection down
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv') -- Move selection up

-- Join lines without moving cursor
vim.keymap.set('n', 'J', 'mzJ`z')

-- Keep cursor centered when scrolling
vim.keymap.set('n', '<C-d>', '<C-d>zz') -- Half-page down
vim.keymap.set('n', '<C-u>', '<C-u>zz') -- Half-page up

-- Keep search matches centered
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Re-indent paragraph and restore cursor position
vim.keymap.set('n', '=ap', 'ma=ap\'a')

-- Restart LSP server
vim.keymap.set('n', '<leader>zig', '<cmd>LspRestart<cr>')

-- Make current file executable
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })

-- Next/Previous buffer
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { desc = 'Previous buffer' })

-- Next/Previous tab
vim.keymap.set('n', '[t', ':tabprevious<CR>', { desc = 'Previous tab' })
vim.keymap.set('n', ']t', ':tabnext<CR>', { desc = 'Next tab' })

-- New/Close tab
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { desc = 'New tab' })
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { desc = 'Close tab' })

-- Clear search highlight on <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR><Esc>', { desc = 'Clear search highlight' })

-- Jump to tab by number (1–9)
for i = 1, 9 do
  vim.keymap.set('n', string.format('<leader>t%d', i), function()
    local tabpages = vim.api.nvim_list_tabpages()
    if tabpages[i] then
      vim.api.nvim_set_current_tabpage(tabpages[i])
    else
      vim.notify('Tab ' .. i .. ' does not exist', vim.log.levels.WARN)
    end
  end, { desc = 'Go to tab ' .. i })
end

-- Copy relative file path
vim.keymap.set('n', '<leader>cp', function()
  local path = vim.fn.expand '%:.'
  vim.fn.setreg('+', path)
  print('📋 Copied relative path: ' .. path)
end, { desc = 'Copy relative file path' })

-- Copy absolute file path
vim.keymap.set('n', '<leader>cP', function()
  local path = vim.fn.expand '%:p'
  vim.fn.setreg('+', path)
  print('📋 Copied absolute path: ' .. path)
end, { desc = 'Copy absolute file path' })

-- Jump to buffer by number (1–9)
for i = 1, 9 do
  vim.keymap.set('n', string.format('<leader>%d', i), function()
    local bufs = vim.api.nvim_list_bufs()
    local valid_bufs = vim.tbl_filter(
      function(b) return vim.api.nvim_buf_is_loaded(b) and vim.bo[b].buflisted end,
      bufs
    )

    if valid_bufs[i] then
      vim.api.nvim_set_current_buf(valid_bufs[i])
    else
      vim.notify('Buffer ' .. i .. ' does not exist', vim.log.levels.WARN)
    end
  end, { desc = 'Go to buffer ' .. i })
end
