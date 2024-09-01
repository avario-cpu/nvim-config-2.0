return {
  "echasnovski/mini.map",
  dependencies = { "lewis6991/gitsigns.nvim" }, -- for git highlighting
  version = false,
  enabled = false,
  config = function()
    local map = require("mini.map")
    map.setup({
      integrations = {
        map.gen_integration.builtin_search(),
        map.gen_integration.diagnostic(),
        map.gen_integration.gitsigns(),
      },
      symbols = {
        encode = map.gen_encode_symbols.dot("4x2"),
        scroll_line = "█",
        scroll_view = "│",
      },
      window = {
        width = 15,
        winblend = 25,
      },
    })

    -- we have to bind keys for this.
  end,
}
