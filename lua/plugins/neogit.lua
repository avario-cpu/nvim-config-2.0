return {
  "NeogitOrg/neogit",
  enabled = false,
  dependencies = {
    "nvim-lua/plenary.nvim", -- required

    -- Only one of these is needed.
    "nvim-telescope/telescope.nvim", -- optional
    "ibhagwan/fzf-lua", -- optional
    "echasnovski/mini.pick", -- optional
  },
  config = true,
}
