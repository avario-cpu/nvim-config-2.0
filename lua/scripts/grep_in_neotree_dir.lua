local function live_grep_neotree_dir()
  -- Get the neo-tree state
  local state = require("neo-tree.sources.manager").get_state("filesystem")
  if not state then
    return
  end

  -- Get the node under the cursor
  local node = state.tree:get_node()
  if not node then
    return
  end

  local path
  if node.type == "directory" then
    path = node:get_id()
  elseif node.type == "file" then
    path = vim.fn.fnamemodify(node:get_id(), ":h")
  else
    print("Not a file or directory")
    return
  end

  -- Use Telescope to live_grep in the selected directory
  require("telescope.builtin").live_grep({ search_dirs = { path } })
end

-- Set up the keymap
vim.api.nvim_create_autocmd("FileType", {
  pattern = "neo-tree",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "<leader>sG", "", {
      noremap = true,
      silent = true,
      callback = live_grep_neotree_dir,
      desc = "Live grep in neotree directory",
    })
  end,
})
