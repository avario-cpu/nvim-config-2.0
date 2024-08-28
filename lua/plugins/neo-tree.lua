return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      -- Ensure the filesystem key exists
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

      -- Ensure the event_handlers key exists
      opts.event_handlers = opts.event_handlers or {}
      -- Add the new event handler
      table.insert(opts.event_handlers, {
        event = "after_render",
        handler = function()
          local state = require("neo-tree.sources.manager").get_state("filesystem")
          if not require("neo-tree.sources.common.preview").is_active() then
            state.config = { use_float = true } -- or whatever your config is
            state.commands.toggle_preview(state)
          end
        end,
      })

      return opts
    end,
  },
}
