local telescope = require("telescope.builtin")

-- Search for imports of the current file, piped to quickfix list
function Search_current_buffer_imports()
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

vim.api.nvim_create_user_command("SearchCurrentBufferImports", Search_current_buffer_imports, {})
vim.api.nvim_set_keymap(
  "n",
  "<leader>si",
  ":SearchCurrentBufferImports<CR>",
  { noremap = true, silent = true, desc = "Search for imports of buffer" }
)

-- Search for imports of the Neotree node
function Search_neotree_node_imports()
  local state = require("neo-tree.sources.manager").get_state("filesystem")
  local node = state.tree:get_node()

  if not node then
    print("No neotree node selected")
    return
  end

  local node_name = vim.fn.fnamemodify(node:get_id(), ":t:r") -- Get filename without extension

  telescope.grep_string({
    prompt_title = "Imports of " .. node_name,
    search = string.format("import.*%s|%s.*import", node_name, node_name),
    use_regex = true,
  })
end

vim.api.nvim_create_user_command("SearchNeotreeNodeImports", Search_neotree_node_imports, {})
vim.api.nvim_set_keymap(
  "n",
  "<leader>sI",
  ":SearchNeotreeNodeImports<CR>",
  { noremap = true, silent = true, desc = "Search for imports of Neotree node" }
)
