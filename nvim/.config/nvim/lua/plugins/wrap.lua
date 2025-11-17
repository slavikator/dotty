-- nvim/.config/nvim/lua/plugins/wrap.lua

local function wrap_selection(line1, line2)
  -- Get the selected lines from the buffer
  local lines = vim.api.nvim_buf_get_lines(0, line1 - 1, line2, false)

  -- Process the lines
  local new_lines = {}
  for _, line in ipairs(lines) do
    local trimmed = vim.fn.trim(line)
    if #trimmed > 0 then
      table.insert(new_lines, "  <li>" .. trimmed .. "</li>")
    end
  end

  -- If we have list items, wrap them in <ul>
  if #new_lines > 0 then
    table.insert(new_lines, 1, "<ul>")
    table.insert(new_lines, "</ul>")
  end

  -- Replace the original lines
  vim.api.nvim_buf_set_lines(0, line1 - 1, line2, false, new_lines)

  -- Format the buffer, if any lines were added
  if #new_lines > 0 then
    local ok, conform = pcall(require, "conform")
    if ok then
      conform.format()
    else
      vim.notify("conform.nvim not found, skipping auto-formatting.", vim.log.levels.WARN)
    end
  end
end

-- Expose the function globally for the command
_G.WrapInUlLi = wrap_selection

-- Create a user command that takes a range, and call the Lua function
vim.cmd("command -range WrapUL lua _G.WrapInUlLi(<line1>, <line2>)")

-- Map the command in visual mode
vim.keymap.set("v", "<C-y>", ":WrapUL<CR>", { desc = "Wrap selection in <ul><li>", silent = true })

return {}
