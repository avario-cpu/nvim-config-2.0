return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "<leader>o",
      function()
        require("oil").open_float()
      end,
      desc = "Open Oil in float mode",
    },
  },
  config = function()
    require("oil").setup({
      keymaps = {
        ["q"] = "actions.close",
      },
    })
  end,
}
