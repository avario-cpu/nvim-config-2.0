-- Yank relative path to clipboard
vim.keymap.set("n", "<leader>yp", function()
  local relative_path = vim.fn.expand("%:p:~:.")
  vim.fn.setreg("+", relative_path)
  vim.notify("Relative path copied to clipboard", vim.log.levels.INFO)
end, { noremap = true, silent = true, desc = "Yank relative path to clipboard" })

-- Search for imports of the current file, piped to quickfix list
vim.keymap.set("n", "<leader>si", function()
  local path = vim.fn.expand("%:p:~:."):gsub("%.[^.]+$", ""):gsub("\\", "/")
  local import_path = path:gsub("/", [[\.]])

  -- Create patterns for both import styles
  local patterns = {
    string.format([[from %s import]], import_path),
    string.format([[import %s]], import_path),
  }

  -- Combine patterns into a single grep command
  local grep_pattern = table.concat(patterns, "\\|")
  local cmd = string.format('silent grep! "%s"', grep_pattern)

  vim.notify("Searching for imports: " .. cmd, vim.log.levels.INFO)

  -- Execute the grep command and open the quickfix window without jumping
  vim.cmd(cmd)
  vim.cmd("copen")
  vim.cmd("wincmd p") -- Move cursor back to the previous window
end, { noremap = true, silent = true, desc = "Search for imports of current file" })
