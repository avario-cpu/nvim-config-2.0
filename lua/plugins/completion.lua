-- vim.o.completeopt = "menuone,noselect,preview"

return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-cmdline" },
    { "zbirenbaum/copilot-cmp", enabled = false },

    enabled = true,
    opts = function(_, opts)
      local cmp = require("cmp")
      local no_action = function() end

      opts.experimental.ghost_text = false

      -- Set preselect mode to None
      opts.preselect = cmp.PreselectMode.None
      local confirm_mapping = cmp.mapping.confirm({ select = true })

      -- Bind keymaps
      opts.mapping = vim.tbl_extend("force", opts.mapping or {}, {
        ["<Tab>"] = cmp.mapping(confirm_mapping, { "c" }),
        ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { "i", "c" }),
        ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i", "c" }),
      })

      -- Setup for cmdline completion
      cmp.setup.cmdline(":", {
        mapping = vim.tbl_extend("force", cmp.mapping.preset.cmdline(), {
          --   ["<c-y>"] = cmp.mapping.confirm({ select = true }),
          -- ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          -- ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          -- ["<Tab>"] = cmp.mapping(no_action),
          ["<Tab>"] = cmp.mapping(confirm_mapping, { "c" }),
          -- ["<S-Tab>"] = cmp.mapping(no_action),
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
          --   ["<c-y>"] = cmp.mapping.confirm({ select = true }),
          -- ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          -- ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          -- ["<Tab>"] = cmp.mapping(no_action),
          ["<Tab>"] = cmp.mapping(confirm_mapping, { "c" }),
          -- ["<S-Tab>"] = cmp.mapping(no_action),
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
