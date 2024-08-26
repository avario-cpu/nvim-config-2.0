local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local telescope = require("telescope")

local function convert_path(path)
  -- Convert backslashes to forward slashes
  return path:gsub("\\", "/")
end

local function get_relative_path(path)
  local relative = vim.fn.fnamemodify(path, ":.")
  return convert_path(relative)
end

local function insert_path(prompt_bufnr, use_relative)
  local selection = action_state.get_selected_entry()
  if selection == nil then
    print("No selection")
    return
  end
  local path = selection.path
  if path == nil then
    print("No path")
    return
  end

  if use_relative then
    path = get_relative_path(path)
  else
    path = convert_path(path)
  end

  actions.close(prompt_bufnr)
  vim.api.nvim_put({ path }, "", false, true)
end

local insert_absolute_path = function(prompt_bufnr)
  insert_path(prompt_bufnr, false)
end

local insert_relative_path = function(prompt_bufnr)
  insert_path(prompt_bufnr, true)
end

telescope.setup({
  defaults = {
    mappings = {
      n = {
        ["="] = insert_absolute_path,
        ["-"] = insert_relative_path,
      },
    },
  },
})

-- Set up the Ctrl+t binding for insert mode Telescope call
vim.keymap.set("i", "<C-t>", function()
  require("telescope.builtin").find_files()
end, { noremap = true, silent = true, desc = "Telescope find files" })
