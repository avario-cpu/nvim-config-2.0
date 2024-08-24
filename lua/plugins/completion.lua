vim.o.completeopt = "menuone,noselect,preview"

return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-cmdline" },
    opts = function(_, opts)
      local cmp = require("cmp")

      -- Unbind enter from selecting completion
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<CR>"] = vim.NIL,
      })

      -- Set preselect mode to None
      opts.preselect = cmp.PreselectMode.None

      -- Cmdline sources
      table.insert(opts.sources, {
        name = "cmdline",
        option = {
          ignore_cmds = { "Man", "!" },
        },
      })

      -- Setup for cmdline completion
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      -- Setup for search completion
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      return opts
    end,
  },
}
