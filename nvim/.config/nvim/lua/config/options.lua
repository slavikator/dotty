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
