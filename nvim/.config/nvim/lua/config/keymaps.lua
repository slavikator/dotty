-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Select all
vim.keymap.set("n", "<leader>a", "ggVG", { desc = "Select whole file" })

-- Copy whole file to system clipboard
vim.keymap.set("n", "<leader>A", ":%y+<CR>", { desc = "Yank whole file to clipboard" })
