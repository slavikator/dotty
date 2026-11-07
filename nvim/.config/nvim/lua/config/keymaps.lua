-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Select all
vim.keymap.set("n", "<leader>za", "ggVG", { desc = "Select whole file" })

-- Copy whole file to system clipboard
vim.keymap.set("n", "<leader>zca", ":%y+<CR>", { desc = "Copy all text" })

-- Go to end of file, leave one empty line after the content and start insert on a new line
-- (if the file already ends with an empty line, reuse it as the separator)
vim.keymap.set("n", "<leader>zo", function()
  local last = vim.fn.getline("$")
  return last:match("^%s*$") and "Go" or "Go<CR>"
end, { expr = true, desc = "Write at end (after empty line)" })

-- Move selected lines up/down in visual mode
vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv', {desc = 'Move selected lines down'})
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv', {desc = 'Move selected lines up'})

-- Restart LSP server
vim.keymap.set('n', '<leader>zr', '<cmd>lsp restart<cr>', {desc = 'Restart LSP server'})

-- Make current file executable
vim.keymap.set('n', '<leader>zx', '<cmd>!chmod +x %<CR>', { silent = true, desc = 'Make current file executable'})

-- Clear search highlight on <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR><Esc>', { desc = 'Clear search highlight' })

-- Copy relative file path
vim.keymap.set('n', '<leader>zcpr', function()
  local path = vim.fn.expand '%:.'
  vim.fn.setreg('+', path)
  print('📋 Copied relative path: ' .. path)
end, { desc = 'Relative' })

-- Jump to buffer by its bufferline ordinal number (1–9)
for i = 1, 9 do
  vim.keymap.set('n', string.format('<leader>%d', i), function()
    require('bufferline').go_to(i, true)
  end, { desc = 'Go to buffer ' .. i })
end

-- Copy absolute file path
vim.keymap.set('n', '<leader>zcpa', function()
  local path = vim.fn.expand '%:p'
  vim.fn.setreg('+', path)
  print('📋 Copied absolute path: ' .. path)
end, { desc = 'Absolute' })

-- Copy filename / stem / directory
local function copy(text, label)
  vim.fn.setreg('+', text)
  print('📋 Copied ' .. label .. ': ' .. text)
end
vim.keymap.set('n', '<leader>zcpf', function() copy(vim.fn.expand '%:t', 'filename') end, { desc = 'Filename' })
vim.keymap.set('n', '<leader>zcpn', function() copy(vim.fn.expand '%:t:r', 'name') end, { desc = 'Name (no extension)' })
vim.keymap.set('n', '<leader>zcpd', function() copy(vim.fn.expand '%:.:h' .. '/', 'directory') end, { desc = 'Directory' })

-- Copy relative path with line number (path:line)
vim.keymap.set('n', '<leader>zcpl', function()
  copy(vim.fn.expand '%:.' .. ':' .. vim.fn.line '.', 'location')
end, { desc = 'Relative with line' })

-- Copy diagnostic message under cursor (falls back to first one on the line)
vim.keymap.set('n', '<leader>zce', function()
  local lnum, col = vim.fn.line '.' - 1, vim.fn.col '.' - 1
  local diags = vim.diagnostic.get(0, { lnum = lnum })
  if #diags == 0 then
    return vim.notify('No diagnostic on this line', vim.log.levels.WARN)
  end
  local pick = diags[1]
  for _, d in ipairs(diags) do
    if col >= d.col and col < (d.end_col or d.col + 1) then
      pick = d
      break
    end
  end
  copy(pick.message, 'diagnostic')
end, { desc = 'Copy diagnostic under cursor' })

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

-- Capitalize first letter of each line in range, skipping indent, list markers
-- (-, *, +, 1., 1)), checkboxes ([ ]) and leading HTML tags (<li>). Unicode-aware.
vim.api.nvim_create_user_command('CapitalizeLines', function(opts)
  local prefix_re = [[\v^\s*%([-*+]\s+|\d+[.)]\s+)?%(\[.\]\s+)?%(\<[^>]*\>\s*)*]]
  local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false)
  for i, line in ipairs(lines) do
    local prefix = vim.fn.matchstr(line, prefix_re)
    local rest = line:sub(#prefix + 1)
    local first = vim.fn.strcharpart(rest, 0, 1)
    lines[i] = prefix .. vim.fn.toupper(first) .. rest:sub(#first + 1)
  end
  vim.api.nvim_buf_set_lines(0, opts.line1 - 1, opts.line2, false, lines)
end, { range = true, desc = 'Capitalize first letter of each line' })
vim.keymap.set('v', '<leader>zu', ':CapitalizeLines<CR>', { silent = true, desc = 'Capitalize first letters' })

-- Strip formatting in range: HTML tags/entities and Markdown syntax (headings, quotes, bullets,
-- numbering, checkboxes, bold/italic/strike/code, links, images). Keeps text, line breaks and
-- relative indentation; drops lines that held only markup (e.g. <ul>, ```, ---).
vim.api.nvim_create_user_command('StripFormatting', function(opts)
  local sub = vim.fn.substitute
  local entities = { amp = '&', lt = '<', gt = '>', quot = '"', apos = "'", nbsp = ' ', ['#39'] = "'" }
  local out = {}
  for _, line in ipairs(vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false)) do
    local was_blank = line:match('^%s*$') ~= nil
    if line:match('^%s*```') or line:match('^%s*[-*_][-*_ ]*$') and #line:gsub('[%s]', '') >= 3 then
      line = ''
    end
    line = line:gsub('<[^>]*>', '')
    line = line:gsub('&(#?%w+);', function(e) return entities[e] end)
    line = sub(line, [[\v^(\s*)%(#{1,6}\s+|\>\s?)*]], [[\1]], '')
    line = sub(line, [[\v^(\s*)%([-*+]\s+|\d+[.)]\s+)?%(\[.\]\s+)?]], [[\1]], '')
    line = sub(line, [=[\v!?\[([^\]]*)\]\([^)]*\)]=], [[\1]], 'g')
    line = sub(line, [[\v`([^`]*)`]], [[\1]], 'g')
    line = sub(line, [[\v(\*\*|__|\~\~)(.{-1,})\1]], [[\2]], 'g')
    line = sub(line, [[\v(^|[^[:alnum:]*])\*([^* ].{-})\*]], [[\1\2]], 'g')
    line = sub(line, [[\v(^|[^[:alnum:]_])_([^_ ].{-})_($|[^[:alnum:]_])]], [[\1\2\3]], 'g')
    line = line:gsub('%s+$', '')
    if was_blank or line ~= '' then
      table.insert(out, line)
    end
  end
  -- Remove indentation common to all non-blank lines
  local min
  for _, l in ipairs(out) do
    if l ~= '' then
      local n = #l:match('^%s*')
      min = math.min(min or n, n)
    end
  end
  for i, l in ipairs(out) do
    out[i] = l:sub((min or 0) + 1)
  end
  vim.api.nvim_buf_set_lines(0, opts.line1 - 1, opts.line2, false, out)
end, { range = true, desc = 'Strip HTML/Markdown formatting' })
vim.keymap.set('v', '<leader>zf', ':StripFormatting<CR>', { silent = true, desc = 'Strip formatting (keep text)' })
