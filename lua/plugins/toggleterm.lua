return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    local original_height = 10 -- Store the original height
    local is_maximized = false -- Flag to track maximized state

    local Terminal = require("toggleterm.terminal").Terminal
    local next_terminal_id = 1

    local function set_terminal_keymaps(term)
      local opts = { buffer = term.bufnr }
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
      vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)

      -- Resize mappings
      vim.keymap.set("t", "<C-Up>", [[<Cmd>resize +2<CR>]], opts)
      vim.keymap.set("t", "<C-Down>", [[<Cmd>resize -2<CR>]], opts)
      vim.keymap.set("t", "<C-Left>", [[<Cmd>vertical resize -2<CR>]], opts)
      vim.keymap.set("t", "<C-Right>", [[<Cmd>vertical resize +2<CR>]], opts)

      -- Toggle maximize mapping
      vim.keymap.set("t", "<C-e>", function()
        if is_maximized then
          vim.cmd("resize " .. original_height)
          is_maximized = false
        else
          original_height = vim.api.nvim_win_get_height(0) -- Store current height before maximizing
          vim.cmd("resize " .. math.floor(vim.o.lines / 2))
          is_maximized = true
        end
      end, opts)

      -- Close (delete) terminal mapping
      vim.keymap.set("t", "<C-d>", function()
        vim.api.nvim_buf_delete(term.bufnr, { force = true })
      end, opts)

      -- Hide terminal mapping
      vim.api.nvim_set_keymap("t", "<C-q>", [[<Cmd>ToggleTermToggleAll<CR>]], { noremap = true, silent = true })
    end

    -- Function to create a new terminal
    local function create_terminal()
      local new_terminal = Terminal:new({
        id = next_terminal_id,
        direction = "horizontal",
        on_open = function(term)
          vim.cmd("startinsert!")
          set_terminal_keymaps(term)
          is_maximized = false -- Reset maximized state when opening a new terminal
        end,
        on_close = function()
          vim.cmd("startinsert!")
        end,
      })
      next_terminal_id = next_terminal_id + 1
      return new_terminal
    end

    -- Function to open a new terminal
    function Open_new_terminal()
      local new_term = create_terminal()
      new_term:open()
    end

    -- Set up keybindings for multi-terminal management
    vim.api.nvim_set_keymap("n", "<Leader>tt", [[<Cmd>ToggleTermToggleAll<CR>]], { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<Leader>tn", [[<Cmd>lua Open_new_terminal()<CR>]], { noremap = true, silent = true })

    require("toggleterm").setup({
      shell = "pwsh.exe -NoLogo -NoExit -Command \"&{. $PROFILE; $Host.UI.RawUI.WindowTitle='Neovim Terminal'}; clear\"",
      size = function(term)
        if term.direction == "horizontal" then
          return original_height -- Use the original_height variable
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
    })
  end,
}
