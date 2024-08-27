-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- delete dashboard weird temp shadas
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local shada_path = vim.fn.expand("C:\\Users\\ville\\AppData\\Local\\nvim-data\\shada\\main.shada.tmp*")
    vim.fn.system("del /Q " .. shada_path)
  end,
})
