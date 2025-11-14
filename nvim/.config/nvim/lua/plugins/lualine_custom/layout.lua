local M = {}

local icons = {
  ukrainian = '🇺🇦',
  us = '🇺🇸',
  unknown = '??',
}

local cached = ''
local last_check = 0

local function get_layout()
  local now = vim.loop.hrtime() / 1e9
  if now - last_check < 0.5 then return cached end
  last_check = now

  local uname = vim.loop.os_uname().sysname

  if uname == 'Darwin' then
    -- macOS
    local handle =
      io.popen [[defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep "KeyboardLayout Name" | sed -e 's/.*= *//' -e 's/;//' -e 's/"//g']]
    if not handle then return cached end
    local out = handle:read '*a' or ''
    handle:close()

    local layout_name = out:lower()

    if layout_name:match 'ukrain' then
      cached = icons.ukrainian
    elseif layout_name:match 'us' or layout_name:match 'u.s.' or layout_name:match 'abc' then
      cached = icons.us
    else
      cached = icons.unknown
    end

    return cached
  else
    -- Linux
    local handle = io.popen 'setxkbmap -query | grep layout | awk \'{print $2}\''
    if not handle then return cached end
    local out = handle:read '*a' or ''
    handle:close()

    local layout = out:upper():gsub('%s+', '')
    if layout == 'UA' then
      cached = icons.ukrainian
    elseif layout == 'US' then
      cached = icons.us
    else
      cached = icons.unknown
    end
    return cached
  end
end

M.layout = function() return get_layout() end

return M

