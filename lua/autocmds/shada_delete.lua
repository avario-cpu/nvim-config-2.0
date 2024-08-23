vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local shada_path = vim.fn.expand("C:\\Users\\ville\\AppData\\Local\\nvim-data\\shada\\main.shada.tmp*")
    vim.fn.system("del /Q " .. shada_path)
  end,
})
