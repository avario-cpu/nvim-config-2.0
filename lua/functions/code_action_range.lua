local M = {}

function M.code_action_on_selection()
  -- Capture the current mode
  local mode = vim.api.nvim_get_mode().mode
  print("Current mode:", mode)

  -- Check if we're in visual mode
  if not string.match(mode, "^[vV\22]") then
    vim.notify("This function should be called in visual mode", vim.log.levels.WARN)
    return
  end

  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  -- Print raw positions
  print("Raw start position:", vim.inspect(start_pos))
  print("Raw end position:", vim.inspect(end_pos))

  -- Check if positions are valid
  if not start_pos or not end_pos or #start_pos < 4 or #end_pos < 4 then
    vim.notify("Invalid position data", vim.log.levels.ERROR)
    return
  end

  -- Convert positions to zero-indexed (LSP format)
  local start_row = start_pos[2] - 1
  local start_col = start_pos[3] - 1
  local end_row = end_pos[2] - 1
  local end_col = end_pos[3] - 1

  -- Print converted positions
  print("Converted start position: line =", start_row, "character =", start_col)
  print("Converted end position: line =", end_row, "character =", end_col)

  -- Ensure that the range is valid
  if start_row >= 0 and start_col >= 0 and end_row >= 0 and end_col >= 0 then
    -- Create the range
    local range = {
      start = { line = start_row, character = start_col },
      ["end"] = { line = end_row, character = end_col },
    }

    -- Print the final range
    print("Final range:", vim.inspect(range))

    -- Invoke code action with the range
    vim.lsp.buf.code_action({
      range = range,
    })
  else
    vim.notify("Invalid selection range for code action", vim.log.levels.ERROR)
  end
end

return M
