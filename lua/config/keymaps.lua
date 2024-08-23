-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set(
  "n",
  "<leader>cA",
  require("functions.code_action_range").code_action_on_selection,
  { noremap = true, silent = true, desc = "Code action on selection" }
)

vim.keymap.set(
  "v",
  "<leader>cA",
  require("functions.code_action_range").code_action_on_selection,
  { noremap = true, silent = true, desc = "Code action on selection" }
)
