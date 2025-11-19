-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Select all
vim.keymap.set("n", "<leader>a", "ggVG", { desc = "Select whole file" })

-- Copy whole file to system clipboard
vim.keymap.set("n", "<leader>A", ":%y+<CR>", { desc = "Yank whole file to clipboard" })

-- Toggle TypeScript extra
vim.keymap.set("n", "<leader>ut", function()
  local path = vim.fn.stdpath("config") .. "/lua/config/lazy.lua"
  local lines = vim.fn.readfile(path)
  local ts_line = "lazyvim.plugins.extras.lang.typescript"
  for i, line in ipairs(lines) do
    if line:find(ts_line, 1, true) then
      if line:find("^%-%-") then -- check if it's commented out
        lines[i] = line:gsub("^%-%- ?", "") -- uncomment
        vim.notify("Enabled TypeScript. Please restart Neovim.", vim.log.levels.INFO, { title = "LazyVim" })
      else
        lines[i] = "-- " .. line -- comment
        vim.notify("Disabled TypeScript. Please restart Neovim.", vim.log.levels.INFO, { title = "LazyVim" })
      end
      vim.fn.writefile(lines, path)
      return
    end
  end
  vim.notify("Could not find TypeScript extra line in lazy.lua.", vim.log.levels.WARN, { title = "LazyVim" })
end, { desc = "Toggle TypeScript Extra" })
