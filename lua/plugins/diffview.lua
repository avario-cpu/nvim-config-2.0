return {
  "sindrets/diffview.nvim",
  keys = {
    { "<leader>gd", desc = "Diffview operations" },
    { "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
    { "<leader>gdc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
  },
  cmd = { "DiffviewOpen", "DiffviewClose" },
  config = function()
    local actions = require("diffview.actions")
    require("diffview").setup({
      keymaps = {
        view = {
          ["q"] = actions.close,
        },
        file_panel = {
          -- Make 'q' close Diffview in the file panel
          ["q"] = actions.close,
        },
        file_history_panel = {
          -- Make 'q' close Diffview in the file history panel
          ["q"] = actions.close,
        },
      },
    })
  end,
}
