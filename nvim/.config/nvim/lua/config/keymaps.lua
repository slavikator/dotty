-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Select all
vim.keymap.set("n", "<leader>a", "ggVG", { desc = "Select whole file" })

-- Copy whole file to system clipboard
vim.keymap.set("n", "<leader>A", ":%y+<CR>", { desc = "Yank whole file to clipboard" })

-- Move selected lines up/down in visual mode
vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv', {desc = 'Move selected lines up'})
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv', {desc = 'Move selected lines down'})

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

-- Copy absolute file path
vim.keymap.set('n', '<leader>zca', function()
  local path = vim.fn.expand '%:p'
  vim.fn.setreg('+', path)
  print('📋 Copied absolute path: ' .. path)
end, { desc = 'Copy absolute file path' })

-- Toggle TypeScript extra
vim.keymap.set("n", "<leader>ut", function()
  local path = vim.fn.stdpath("config") .. "/lua/config/lazy.lua"
  local lines = vim.fn.readfile(path)
  local ts_line = "lazyvim.plugins.extras.lang.typescript"
  for i, line in ipairs(lines) do
    if line:find(ts_line, 1, true) then
      if line:find("^%-%-") then -- check if it's commented out
        lines[i] = line:gsub("^%-%- ?", "") -- uncomment
        vim.notify("Enabled TypeScript. Please restart Neovim.", vim.log.levels.INFO, { title = "LazyVim" })
      else
        lines[i] = "-- " .. line -- comment
        vim.notify("Disabled TypeScript. Please restart Neovim.", vim.log.levels.INFO, { title = "LazyVim" })
      end
      vim.fn.writefile(lines, path)
      return
    end
  end
  vim.notify("Could not find TypeScript extra line in lazy.lua.", vim.log.levels.WARN, { title = "LazyVim" })
end, { desc = "Toggle TypeScript Extra" })


-- Toggle Emmet
vim.keymap.set("n", "<leader>ue", function()
  _G.emmet_enabled = not _G.emmet_enabled

  if _G.emmet_enabled then
    vim.notify("Emmet enabled")
  else
    vim.notify("Emmet disabled")

    -- stop running Emmet LSP clients
    for _, client in pairs(vim.lsp.get_active_clients()) do
      if client.name == "emmet_language_server" then
        client.stop(true)
      end
    end
  end
end, { desc = "Toggle Emmet LSP" })
