-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- -- Disable clipboard integration
vim.opt.clipboard = ""
vim.opt.undofile = true
vim.opt.undodir = os.getenv("USERPROFILE") .. "/AppData/Local/nvim/undo/"

vim.opt.wrap = true
vim.opt.scrolloff = 12
vim.g.indent_blankline_show_current_context = false
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.listchars:append("trail:·")
