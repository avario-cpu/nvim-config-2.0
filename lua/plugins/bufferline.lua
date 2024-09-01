return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  opts = function()
    return {
      options = {
        always_show_bufferline = true, -- This keeps the bufferline always visible
      },
      highlights = {
        fill = {
          bg = "#222436", -- Change this to your desired background color
        },
      },
    }
  end,
}
