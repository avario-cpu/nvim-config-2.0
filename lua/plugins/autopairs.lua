return {
  "windwp/nvim-autopairs",
  enabled = true, -- disabled for super specific use case of wrapping with "(" before a line conflicting with vim visual multi
  event = "InsertEnter",
  config = function()
    local npairs = require("nvim-autopairs")

    -- Setup nvim-autopairs with optional configuration
    npairs.setup({
      check_ts = true, -- Enable treesitter integration if you use treesitter
      fast_wrap = {}, -- Fast wrap feature
    })
  end,
}
