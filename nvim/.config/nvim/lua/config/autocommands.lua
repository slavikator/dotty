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
