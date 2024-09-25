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
      opts.window.mappings["<leader>Y"] = function(state)
        local node = state.tree:get_node()
        if node then
          local filepath = node:get_id()
          -- Get the filename without extension
          local filename = vim.fn.fnamemodify(filepath, ":t:r")
          vim.fn.setreg("+", filename)
          vim.notify("Yanked to clipboard: " .. filename)
        end
      end

      return opts
    end,
  },
}
