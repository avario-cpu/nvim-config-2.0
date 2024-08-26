vim.o.completeopt = "menuone,noselect,preview"

return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-cmdline" },
    opts = function(_, opts)
      local cmp = require("cmp")

      -- Set preselect mode to None
      opts.preselect = cmp.PreselectMode.None

      opts.mapping = vim.tbl_extend("force", opts.mapping or {}, {
        -- ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        -- ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      })

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
