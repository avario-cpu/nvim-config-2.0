return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    opts.options = opts.options or {}

    -- Override specific highlights after the theme is set
    local custom_horizon = require("lualine.themes.horizon")
    -- local custom_bg = "#232336"

    -- Set pink background for all available modes
    -- custom_horizon.normal.c.bg = custom_bg
    -- custom_horizon.insert.c.bg = custom_bg
    -- custom_horizon.visual.c.bg = custom_bg
    -- custom_horizon.replace.c.bg = custom_bg
    -- custom_horizon.command.c.bg = custom_bg
    -- custom_horizon.inactive.c.bg = custom_bg
    -- if custom_horizon.terminal then
    --   custom_horizon.terminal.c.bg = custom_bg
    -- end
    -- if custom_horizon.select then
    --   custom_horizon.select.c.bg = custom_bg
    -- end

    opts.options.theme = custom_horizon

    table.insert(opts.sections.lualine_x, 3, {
      function()
        return require("copilot_status").status_string()
      end,
      cnd = function()
        return require("copilot_status").enabled()
      end,
    })

    table.insert(opts.sections.lualine_x, 2, {
      "harpoon2",
      icon = "󱡅", -- Harpoon icon (requires a Nerd Font)
      indicators = { "1", "2", "3", "4", "5" },
      active_indicators = { "[1]", "[2]", "[3]", "[4]", "[5]" },
      -- color = { fg = "#BD9800" }, -- Default color (Horizon ink color)
      color_active = { fg = "#ff6186", gui = "bold" }, -- Active color (Horizon ink color)
      -- separator = " ",
      component_separators = { left = "", right = "" },
      no_harpoon = "Harpoon not loaded",
    })

    return opts
  end,
}
