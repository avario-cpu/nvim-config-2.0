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

-- Center cursor after search using Enter
vim.api.nvim_create_autocmd("CmdlineEnter", {
  callback = function()
    vim.keymap.set("c", "<CR>", function()
      if vim.fn.getcmdtype() == "/" or vim.fn.getcmdtype() == "?" then
        return "<CR>zz"
      end
      return "<CR>"
    end, { expr = true, buffer = true })
  end,
})

-- Enable wrap for diffs, with no mid-word wrap
vim.api.nvim_create_autocmd("FileType", {
  pattern = "diff",
  command = "setlocal wrap linebreak",
})
