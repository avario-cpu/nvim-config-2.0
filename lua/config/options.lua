-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- -- Disable clipboard integration
vim.opt.clipboard = ""
vim.opt.undofile = true
vim.opt.undodir = os.getenv("USERPROFILE") .. "/AppData/Local/nvim/undo/"

vim.cmd([[autocmd FileType * set formatoptions-=ro]])

-- Enable wrap for diffs, with no mid-word wrap
vim.api.nvim_create_autocmd("FileType", {
  pattern = "diff",
  command = "setlocal wrap linebreak",
})
