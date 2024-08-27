local M = {}

function M.append_file_to_system_register()
  vim.cmd('normal! ggVG"my')
  local current_clipboard = vim.fn.getreg("+")
  local m_register = vim.fn.getreg("m")
  vim.fn.setreg("+", current_clipboard .. m_register)
end

function M.append_reg_to_sys_clipboard()
  -- Get the contents of the unnamed register
  local unnamed_register = vim.fn.getreg('"')
  -- Get the current contents of the system clipboard
  local system_register = vim.fn.getreg("+")
  -- Concatenate the contents of both registers with an empty new line in between
  local new_register_content = system_register .. "\n\n" .. unnamed_register
  -- Set the concatenated result back to the system clipboard
  vim.fn.setreg("+", new_register_content)
end

return M
