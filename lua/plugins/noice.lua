return {
  "folke/noice.nvim",
  enabled = true,
  opts = function(_, opts)
    opts.presets = {
      bottom_search = false,
      command_palette = {
        views = {
          cmdline_popup = {
            position = {
              row = "50%",
              col = "50%",
            },
            size = {
              min_width = 60,
              width = "auto",
              height = "auto",
            },
          },
        },
      },
    }

    -- Disable automatic signature help
    opts.lsp = opts.lsp or {}
    opts.lsp.signature = {
      auto_open = { enabled = false },
    }

    return opts
  end,
}
