return {
  "telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-fzf-native.nvim",
  },
  opts = function(_, opts)
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")

    -- Override the live_grep function
    local old_live_grep = builtin.live_grep
    builtin.live_grep = function(live_grep_opts)
      live_grep_opts = vim.tbl_extend("force", {
        attach_mappings = function(_, map)
          map("i", "<c-e>", actions.to_fuzzy_refine)
          return true
        end,
        layout_strategy = "vertical",
        layout_config = {
          width = 0.8,
          height = 0.9,
        },
      }, live_grep_opts or {})
      old_live_grep(live_grep_opts)
    end

    -- Override the lsp_references function
    local old_lsp_references = builtin.lsp_references
    builtin.lsp_references = function(lsp_references_opts)
      lsp_references_opts = vim.tbl_deep_extend("force", {
        layout_strategy = "vertical",
        layout_config = {
          width = 0.8,
          height = 0.9,
        },
      }, lsp_references_opts or {})
      old_lsp_references(lsp_references_opts)
    end

    return opts
  end,
}
