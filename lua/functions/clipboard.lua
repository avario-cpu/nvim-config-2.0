local M = {}

function M.append_file_to_system_register()
  vim.cmd('normal! ggVG"my')
  local current_clipboard = vim.fn.getreg("+")
  local m_register = vim.fn.getreg("m")
  vim.fn.setreg("+", current_clipboard .. m_register)
end

function M.append_empty_reg_to_system_reg()
  local unnamed_register = vim.fn.getreg('"')
  local system_register = vim.fn.getreg("+")
  local new_register_content = system_register .. "\n\n\n" .. unnamed_register
  vim.fn.setreg("+", new_register_content)
end

return M
