-- Function to delete shada temp files
function Delete_shada_temp_files()
  local shada_path = vim.fn.expand("C:\\Users\\ville\\AppData\\Local\\nvim-data\\shada\\main.shada.tmp*")
  local deleted = vim.fn.delete(shada_path, "rf")
  if deleted == 0 then
    print("Deleted shada temp files")
  else
    print("No shada temp files found or unable to delete")
  end
end

-- Create the keymapping
vim.api.nvim_set_keymap(
  "n",
  "<leader>DS",
  ":lua Delete_shada_temp_files()<CR>",
  { noremap = true, silent = true, desc = "Delete shada temp files" }
)
