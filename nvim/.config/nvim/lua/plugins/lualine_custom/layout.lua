local M = {}

local term_program = vim.env.TERM_PROGRAM
local term_supports_emoji = (term_program == "ghostty" or term_program == "iTerm.app")
local use_emoji = vim.fn.has("gui_running") == 1 or term_supports_emoji

local icons = {
  ukrainian = use_emoji and "🇺🇦" or "UA",
  us = use_emoji and "🇺🇸" or "EN",
  unknown = "??",
}

local cached = ""
local last_check = 0

local function get_layout()
  local now = vim.loop.hrtime() / 1e9
  if now - last_check < 0.5 then
    return cached
  end
  last_check = now

  local uname = vim.loop.os_uname().sysname

  if uname == "Darwin" then
    -- macOS
    local handle =
      io.popen([[defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep "KeyboardLayout Name" | sed -e 's/.*= *//' -e 's/;//' -e 's/"//g']])
    if not handle then
      return cached
    end
    local out = handle:read("*a") or ""
    handle:close()

    local layout_name = out:lower()

    if layout_name:match("ukrain") then
      cached = icons.ukrainian
    elseif layout_name:match("us") or layout_name:match("u.s.") or layout_name:match("abc") then
      cached = icons.us
    else
      cached = icons.unknown
    end

    return cached
  else
    -- Linux
    local handle = io.popen("setxkbmap -query | grep layout | awk '{print $2}'")
    if not handle then
      return cached
    end
    local out = handle:read("*a") or ""
    handle:close()

    local layout = out:upper():gsub("%s+", "")
    if layout == "UA" then
      cached = icons.ukrainian
    elseif layout == "US" then
      cached = icons.us
    else
      cached = icons.unknown
    end
    return cached
  end
end

M.layout = function()
  return get_layout()
end

return M
