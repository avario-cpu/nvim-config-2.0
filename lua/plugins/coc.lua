return {
  "neoclide/coc.nvim",
  branch = "release",
  enabled = true,
  vim.api.nvim_set_keymap("n", "gR", "<Plug>(coc-references)", { silent = true, noremap = true }),
  vim.keymap.set("v", "<leader>cC", "<Plug>(coc-codeaction-selected)"),
}
