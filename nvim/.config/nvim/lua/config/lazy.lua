-- This file bootstraps the lazy.nvim plugin manager.
-- It ensures that lazy.nvim is installed and then sets it up to load plugins
-- from the 'lua/plugins' directory.

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load all plugins from the lua/plugins folder
require("lazy").setup("plugins", {
  change_detection = { notify = false },
})

