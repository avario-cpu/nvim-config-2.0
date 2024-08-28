-- vim.o.completeopt = "menuone,noselect,preview"

return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-cmdline" },
    opts = function(_, opts)
      local cmp = require("cmp")

      -- Set preselect mode to None
      opts.preselect = cmp.PreselectMode.None
      local confirm_mapping = cmp.mapping.confirm({ select = true })

      opts.mapping = vim.tbl_extend("force", opts.mapping or {}, {
        ["<c-y>"] = cmp.mapping(confirm_mapping, { "i", "c", "s" }),
      })

      table.insert(opts.sources, {
        name = "cmdline",
        option = {
          ignore_cmds = { "Man", "!" },
        },
      })

      -- Setup for cmdline completion
      cmp.setup.cmdline(":", {
        mapping = vim.tbl_extend("force", cmp.mapping.preset.cmdline(), {
          ["<c-y>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      -- Setup for search completion
      cmp.setup.cmdline("/", {
        mapping = vim.tbl_extend("force", cmp.mapping.preset.cmdline(), {
          ["<c-y>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "buffer" },
        },
      })

      -- Fix ghost text on completion
      local feedkeys = vim.api.nvim_feedkeys
      local termcodes = vim.api.nvim_replace_termcodes
      local function feed_space_backspace()
        feedkeys(termcodes(" <BS>", true, false, true), "n", true)
      end

      cmp.event:on("confirm_done", feed_space_backspace)

      return opts
    end,
  },
}
