local Util = require("lazyvim.util")

-- Function to set ANSI color
local function set_ansi_color(idx, color)
  local channel_id = vim.b.terminal_job_id
  if channel_id then
    local command = string.format("\27]4;%d;%s\7", idx, color)
    vim.fn.chansend(channel_id, command)
  else
    vim.notify("No terminal job ID found.", vim.log.levels.ERROR)
  end
end

-- Function to check clipboard with retries
local function getRelativeFilepath(retries, delay)
  local relative_filepath
  for _ = 1, retries do
    relative_filepath = vim.fn.getreg("+")
    if relative_filepath ~= "" then
      return relative_filepath -- Return filepath if clipboard is not empty
    end
    vim.loop.sleep(delay) -- Wait before retrying
  end
  return nil -- Return nil if clipboard is still empty after retries
end

-- Function to handle editing from Lazygit
function LazygitEdit(original_buffer)
  local current_bufnr = vim.fn.bufnr("%")
  local channel_id = vim.fn.getbufvar(current_bufnr, "terminal_job_id")

  if not channel_id then
    vim.notify("No terminal job ID found.", vim.log.levels.ERROR)
    return
  end

  vim.fn.chansend(channel_id, "\15") -- \15 is <c-o>
  vim.cmd("close") -- Close Lazygit

  local relative_filepath = getRelativeFilepath(5, 50)
  if not relative_filepath then
    vim.notify("Clipboard is empty or invalid.", vim.log.levels.ERROR)
    return
  end

  local winid = vim.fn.bufwinid(original_buffer)

  if winid == -1 then
    vim.notify("Could not find the original window.", vim.log.levels.ERROR)
    return
  end

  vim.fn.win_gotoid(winid)
  vim.cmd("e " .. relative_filepath)
end

function OpenLazygitLogs()
  Util.terminal.open({ "lazygit", "log" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false })
end

-- Function to start Lazygit in a floating terminal
function StartLazygit()
  local current_buffer = vim.api.nvim_get_current_buf()
  local float_term = Util.terminal.open({ "lazygit" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false })

  -- Set custom colors for the Lazygit terminal
  set_ansi_color(1, "#FF0000") -- Set color 1 to red
  set_ansi_color(2, "#00FF00") -- Set color 2 to green

  vim.api.nvim_buf_set_keymap(
    float_term.buf,
    "t",
    "<C-g>", -- Go to file in current nvin instance
    string.format([[<Cmd>lua LazygitEdit(%d)<CR>]], current_buffer),
    { noremap = true, silent = true }
  )
end
