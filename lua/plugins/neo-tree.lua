return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      -- Ensure the filesystem key exists
      opts.filesystem = opts.filesystem or {}

      -- Ensure the window mappings exist
      opts.window = opts.window or {}
      opts.window.mappings = opts.window.mappings or {}

      -- Override the "P" mapping to use float
      opts.window.mappings["P"] = {
        "toggle_preview",
        config = {
          use_float = true,
        },
      }

      opts.window.mappings["s"] = "none" -- unbind to be able to use flash
      opts.window.mappings["S"] = "open_vsplit"

      return opts
    end,
  },
}
