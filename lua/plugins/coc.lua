return {
  "neoclide/coc.nvim",
  branch = "release",
  vim.api.nvim_set_keymap("n", "gR", "<Plug>(coc-references)", { silent = true, noremap = true }),
}
