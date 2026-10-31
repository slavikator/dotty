-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Select all
vim.keymap.set("n", "<leader>a", "ggVG", { desc = "Select whole file" })

-- Copy whole file to system clipboard
vim.keymap.set("n", "<leader>A", ":%y+<CR>", { desc = "Yank whole file to clipboard" })

-- Move selected lines up/down in visual mode
vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv', {desc = 'Move selected lines down'})
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv', {desc = 'Move selected lines up'})

-- Restart LSP server
vim.keymap.set('n', '<leader>zr', '<cmd>LspRestart<cr>', {desc = 'Restart LSP server'})

-- Make current file executable
vim.keymap.set('n', '<leader>zx', '<cmd>!chmod +x %<CR>', { silent = true, desc = 'Make current file executable'})

-- Clear search highlight on <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR><Esc>', { desc = 'Clear search highlight' })

-- Copy relative file path
vim.keymap.set('n', '<leader>zcr', function()
  local path = vim.fn.expand '%:.'
  vim.fn.setreg('+', path)
  print('📋 Copied relative path: ' .. path)
end, { desc = 'Copy relative file path' })

-- Jump to buffer by its bufferline ordinal number (1–9)
for i = 1, 9 do
  vim.keymap.set('n', string.format('<leader>%d', i), function()
    require('bufferline').go_to(i, true)
  end, { desc = 'Go to buffer ' .. i })
end

-- Copy absolute file path
vim.keymap.set('n', '<leader>zca', function()
  local path = vim.fn.expand '%:p'
  vim.fn.setreg('+', path)
  print('📋 Copied absolute path: ' .. path)
end, { desc = 'Copy absolute file path' })

-- Toggle TypeScript extra (stored in lazyvim.json, same as :LazyExtras)
vim.keymap.set("n", "<leader>ut", function()
  local ts_extra = "lazyvim.plugins.extras.lang.typescript"
  local data = LazyVim.config.json.data

  if vim.tbl_contains(data.extras, ts_extra) then
    data.extras = vim.tbl_filter(function(e) return e ~= ts_extra end, data.extras)
    vim.notify("Disabled TypeScript. Please restart Neovim.", vim.log.levels.INFO, { title = "LazyVim" })
  else
    table.insert(data.extras, ts_extra)
    table.sort(data.extras)
    vim.notify("Enabled TypeScript. Please restart Neovim.", vim.log.levels.INFO, { title = "LazyVim" })
  end

  LazyVim.json.save()
end, { desc = "Toggle TypeScript Extra" })


-- Toggle Emmet
vim.keymap.set("n", "<leader>ue", function()
  _G.emmet_enabled = not _G.emmet_enabled

  if _G.emmet_enabled then
    vim.notify("Emmet enabled")
  else
    vim.notify("Emmet disabled")

    -- stop running Emmet LSP clients
    for _, client in ipairs(vim.lsp.get_clients({ name = "emmet_language_server" })) do
      client:stop(true)
    end
  end
end, { desc = "Toggle Emmet LSP" })
