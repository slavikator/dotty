return {
  "L3MON4D3/LuaSnip",
  opts = function(_, opts)
    local ls = require("luasnip")
    local parse = ls.parser.parse_snippet

    ls.add_snippets("all", {
      parse(
        "rafceuc",
        [[
"use client"

const ${1:${TM_FILENAME_BASE}} = () => {
  return (
    <div>${0}</div>
  )
}

export default ${TM_FILENAME_BASE}
]]
      ),
    })
  end,
}
