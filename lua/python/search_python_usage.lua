local telescope = require("telescope.builtin")

-- Search for occurrences of the current buffer name (without extension)
function Search_current_buffer_occurrences()
  local current_file = vim.fn.expand("%:t:r") -- Get filename without extension
  if current_file ~= "" then
    telescope.grep_string({
      prompt_title = "Occurrences of " .. current_file,
      search = current_file,
      use_regex = false,
    })
  else
    print("Not a valid file")
  end
end

vim.api.nvim_create_user_command("SearchCurrentBufferOccurrences", Search_current_buffer_occurrences, {})
vim.api.nvim_set_keymap(
  "n",
  "<leader>so",
  ":SearchCurrentBufferOccurrences<CR>",
  { noremap = true, silent = true, desc = "Search for occurrences of buffer" }
)

-- Search for occurrences of the Neotree node name
function Search_neotree_node_occurrences()
  local state = require("neo-tree.sources.manager").get_state("filesystem")
  local node = state.tree:get_node()

  if not node then
    print("No node selected")
    return
  end

  local node_name = vim.fn.fnamemodify(node:get_id(), ":t:r") -- Get filename without extension

  telescope.grep_string({
    prompt_title = "Occurrences of " .. node_name,
    search = node_name,
    use_regex = false,
  })
end

vim.api.nvim_create_user_command("SearchNeotreeNodeOccurrences", Search_neotree_node_occurrences, {})
vim.api.nvim_set_keymap(
  "n",
  "<leader>sO",
  ":SearchNeotreeNodeOccurrences<CR>",
  { noremap = true, silent = true, desc = "Search for occurrences of Neotree node" }
)
