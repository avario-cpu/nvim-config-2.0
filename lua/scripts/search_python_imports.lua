-- Yank buffer's relative path to clipboard
vim.keymap.set("n", "<leader>yp", function()
  local relative_path = vim.fn.expand("%:p:~:.")
  vim.fn.setreg("+", relative_path)
  vim.notify("Relative path copied to clipboard", vim.log.levels.INFO)
end, { noremap = true, silent = true, desc = "Yank relative path to clipboard" })

local telescope = require("telescope.builtin")

-- Search for imports of the current file, piped to quickfix list
function Find_current_buffer_imports()
  local current_file = vim.fn.expand("%:t")
  local module_name = current_file:gsub("%.py$", "")

  if module_name ~= "" then
    telescope.grep_string({
      prompt_title = "Imports of " .. module_name,
      search = module_name .. ".*import",
      use_regex = true,
    })
  else
    print("Not a valid Python file")
  end
end

vim.api.nvim_create_user_command("FindCurrentBufferImports", Find_current_buffer_imports, {})
vim.api.nvim_set_keymap("n", "<leader>si", ":FindCurrentBufferImports<CR>", { noremap = true, silent = true })
