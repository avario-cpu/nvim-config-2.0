-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { noremap = true, silent = true }
local map = vim.keymap.set

vim.keymap.set(
  "n",
  "<leader>cB",
  require("functions.code_action_range").code_action_on_selection,
  { noremap = true, silent = true, desc = "Code action on selection" }
)

vim.keymap.set(
  "v",
  "<leader>cB",
  require("functions.code_action_range").code_action_on_selection,
  { noremap = true, silent = true, desc = "Code action on selection" }
)

map("n", "<leader>CA", 'ggVG"+y', opts)
map("v", "<C-y>", '"+y', opts)
map("n", "U", "<C-r>")
map("n", "<A-h>", "zH", opts)
map("n", "<A-l>", "zL", opts)

-- test too
-- but different
