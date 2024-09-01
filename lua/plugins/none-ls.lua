return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          -- null_ls.builtins.formatting.isort,
          -- null_ls.builtins.formatting.black,
          -- null_ls.builtins.diagnostics.flake8,
          -- null_ls.builtins.diagnostics.mypy,
          null_ls.builtins.diagnostics.pylint,
        },
        autostart = true,
      })
    end,
  },
}
