return {
  "gorbit99/codewindow.nvim",
  keys = {
    {
      "<leader>mo",
      function()
        require("codewindow").open_minimap()
      end,
      desc = "Open minimap",
    },
    {
      "<leader>mf",
      function()
        require("codewindow").toggle_focus()
      end,
      desc = "Toggle minimap focus",
    },
    {
      "<leader>mc",
      function()
        require("codewindow").close_minimap()
      end,
      desc = "Close minimap",
    },
    {
      "<leader>mm",
      function()
        require("codewindow").toggle_minimap()
      end,
      desc = "Toggle minimap",
    },
  },
  config = function()
    require("codewindow").setup({
      minimap_width = 10,
      screen_bounds = "background",
      width_multiplier = 3,
    })
  end,
}
