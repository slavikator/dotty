-- This file contains general Neovim settings and options.
-- These are fundamental settings that are not specific to any single plugin.

-- Line numbers
-- vim.o.number = true -- Show absolute line numbers on the left

-- Search
vim.o.incsearch = true -- Show search matches incrementally while typing
vim.o.hlsearch = true -- Highlight all matches of the last search

-- Cursor style (commented out)
-- vim.opt.guicursor = ''           -- Use default cursor style

-- Tabs and indentation
vim.opt.tabstop = 4 -- Number of spaces that a <Tab> counts for
vim.opt.softtabstop = 4 -- Number of spaces for Tab while editing
vim.opt.shiftwidth = 4 -- Number of spaces for autoindent (>> and <<)
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.smartindent = true -- Automatically insert indents in code blocks

-- Wrapping
vim.opt.wrap = false -- Disable line wrapping

-- Swap, backup, and undo
vim.opt.swapfile = false -- Disable swapfile creation
vim.opt.backup = false -- Disable backup files
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir' -- Directory to store undo files
vim.opt.undofile = true -- Enable persistent undo

-- Search highlighting (redundant with previous, but left as override)
vim.opt.hlsearch = false -- Disable highlighting search matches
vim.opt.incsearch = true -- Keep incremental search enabled

-- Colors
vim.opt.termguicolors = true -- Enable 24-bit RGB color support

-- Scrolling and signs
vim.opt.scrolloff = 8 -- Keep 8 lines visible above/below cursor when scrolling
vim.opt.signcolumn = 'yes' -- Always show sign column (duplicate of above, harmless)
vim.opt.isfname:append '@-@' -- Allow `@-@` in file names for commands like gf

-- Performance / responsiveness
vim.opt.updatetime = 50 -- Faster update time for CursorHold and other events

-- Visual guide
-- vim.opt.colorcolumn = '80' -- Highlight column 80 as a guide for line length
