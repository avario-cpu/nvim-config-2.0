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

-- override OG lazygit with our custom solution
vim.api.nvim_set_keymap("n", "<leader>gg", [[<Cmd>lua StartLazygit()<CR>]], { noremap = true, silent = true })

map("n", "<leader>CA", 'ggVG"+y', opts)
map("v", "<C-y>", '"+y', opts)
map("n", "U", "<C-r>")
map("n", "<A-h>", "zH", opts)
map("n", "<A-l>", "zL", opts)

-- Navigation
map("n", "G", "Gzz", opts)
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "{", "{zz", opts)
map("n", "}", "}zz", opts)
map("n", "n", "nzz", opts)
map("n", "N", "Nzz", opts)
map("n", "*", "*zz", opts)
map("n", "#", "#zz", opts)
map("n", "%", "%zz", opts)
map("n", "``", "``zz", opts)

-- clipboard
local clipboard_utils = require("functions.clipboard")
map(
  "n",
  "<leader>CP",
  clipboard_utils.append_file_to_system_register,
  opts,
  { desc = "Append file content to system clipboard" }
)
map(
  "n",
  "<leader>+",
  clipboard_utils.append_file_to_system_register,
  opts,
  { desc = "Send register to system clipboard" }
)
-- Lazy
map("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "Lazy" })
map("n", "<leader>lx", "<cmd>LazyExtras<cr>", { desc = "LazyExtras" })
