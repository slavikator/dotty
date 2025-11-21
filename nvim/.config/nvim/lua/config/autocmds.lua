-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Emmet
_G.emmet_enabled = true
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "css","eruby","html","htmldjango","javascriptreact","less","pug",
    "sass","scss","typescriptreact"
  },
  callback = function()
    if not _G.emmet_enabled then
      return
    end

    vim.lsp.start({
      cmd = { "emmet-language-server", "--stdio" },
      root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
      name = "emmet_language_server",
    })
  end,
})

-- Clear search highlight when entering insert mode
vim.api.nvim_create_autocmd('InsertEnter', {
  callback = function()
    if vim.v.hlsearch == 1 then vim.cmd 'nohlsearch' end
  end,
})

-- Automatic enabling of numbering and statuscolumn for real documents
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  callback = function()
    if vim.bo.filetype ~= 'dashboard' then
      vim.wo.number = true
      vim.wo.relativenumber = true
    end
  end,
})
