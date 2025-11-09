-- Cmd+X — cut selection to system clipboard
vim.keymap.set('v', '<D-x>', '"+d', { desc = 'Cut to system clipboard' })

-- Cmd+A — select all text in the buffer
vim.keymap.set({'n', 'v', 'i'}, '<D-a>', '<Esc>ggVG', { desc = 'Select all' })

-- Next/Previous buffer
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })

-- Copy relative file path
vim.keymap.set("n", "<leader>cp", function()
  local path = vim.fn.expand("%:.")
  vim.fn.setreg("+", path)
  print("📋 Copied relative path: " .. path)
end, { desc = "Copy relative file path" })

-- Copy absolute file path
vim.keymap.set("n", "<leader>cP", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  print("📋 Copied absolute path: " .. path)
end, { desc = "Copy absolute file path" })


-- Jump to buffer by number (1–9)
for i = 1, 9 do
  vim.keymap.set("n", string.format("<leader>%d", i), function()
    local bufs = vim.api.nvim_list_bufs()
    local valid_bufs = vim.tbl_filter(function(b)
      return vim.api.nvim_buf_is_loaded(b) and vim.bo[b].buflisted
    end, bufs)

    if valid_bufs[i] then
      vim.api.nvim_set_current_buf(valid_bufs[i])
    else
      vim.notify("Buffer " .. i .. " does not exist", vim.log.levels.WARN)
    end
  end, { desc = "Go to buffer " .. i })
end


