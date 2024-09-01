return {
  "gorbit99/codewindow.nvim",
  config = function()
    local codewindow = require("codewindow")
    codewindow.setup({
      minimap_width = 10,
      screen_bounds = "background",
      width_multiplier = 3,
    })
    codewindow.apply_default_keybinds()
  end,
}
