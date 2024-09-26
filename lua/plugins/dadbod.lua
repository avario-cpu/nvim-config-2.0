return {
  {
    "tpope/vim-dadbod",
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },
    opts = {
      db_completion = function()
        require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
      end,
    },
    config = function(_, opts)
      vim.g.db_ui_save_location = vim.fn.stdpath("config") .. "/db_ui"

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sql", "mysql", "plsql" },
        callback = function()
          vim.schedule(opts.db_completion)
        end,
      })

      -- Optional: Add key mappings
      vim.api.nvim_set_keymap("n", "<leader>du", ":DBUIToggle<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>df", ":DBUIFindBuffer<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>dr", ":DBUIRenameBuffer<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>dl", ":DBUILastQueryInfo<CR>", { noremap = true, silent = true })
    end,
  },
}
