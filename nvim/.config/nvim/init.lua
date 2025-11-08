-- Main Neovim configuration entry point
-- Sets global leader keys and loads options and plugins.

vim.g.mapleader = " "
vim.g.maplocalleader = " "
require("config.options")
require("config.lazy")
