return {
  "neoclide/coc.nvim",
  branch = "release",
  enabled = false,
  vim.api.nvim_set_keymap("n", "gR", "<Plug>(coc-references)", { silent = true, noremap = true }),
  vim.keymap.set("v", "<leader>cR", "<Plug>(coc-codeaction-selected)"),
}
