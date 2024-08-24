return {
  "windwp/nvim-autopairs",
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
