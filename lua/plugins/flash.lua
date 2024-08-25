return {
  "folke/flash.nvim",
  opts = {
    modes = {
      char = {
        jump_labels = true,
      },
    },
  },
  vim.keymap.set("n", "<leader>fw", function()
    require("flash").jump({
      pattern = vim.fn.expand("<cword>"),
    })
  end, { desc = "Flash jump to word under cursor" }),
}
