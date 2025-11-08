-- This file contains general Neovim settings and options.
-- These are fundamental settings that are not specific to any single plugin.

vim.o.number = true

-- Enable incremental search and highlight search results
vim.o.incsearch = true

vim.o.hlsearch = true

-- Clear search highlight on <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>", { desc = "Clear search highlight" })

-- Clear search highlight when entering insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  command = "nohlsearch",
})

-- Automatic enabling of numbering and statuscolumn for real documents
vim.api.nvim_create_autocmd({"BufRead","BufNewFile"}, {
  callback = function()
    if vim.bo.filetype ~= "dashboard" then
      vim.wo.number = true
      vim.wo.relativenumber = false
    end
  end,
})

