return {
  "mg979/vim-visual-multi",
  enabled = true,
  config = function()
    -- More obvious cursor highlighting
    vim.cmd([[
      highlight link VM_Extend IncSearch 
      highlight link VM_Insert IncSearch 
      highlight link VM_Cursor IncSearch 
      highlight link MultiCursor IncSearch 
      ]])

    -- First cursor is added with [I]nitial key as to pause the keymap to navigate better.
    vim.api.nvim_set_keymap("n", "<Leader>I", "<M-L><M-H>", { noremap = false, silent = true })
    -- Dropoff cursor at current position

    vim.api.nvim_set_keymap("n", "<M-L>", "<Plug>(VM-Add-Cursor-At-Pos)", { noremap = true, silent = true })
    -- Toggle cursors shifting with HJKL
    vim.api.nvim_set_keymap("n", "<M-H>", "<Plug>(VM-Toggle-Mappings)", { noremap = true, silent = true })

    -- Add cursors up/down
    vim.api.nvim_set_keymap("n", "<M-K>", "<Plug>(VM-Add-Cursor-Up)", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<M-J>", "<Plug>(VM-Add-Cursor-Down)", { noremap = true, silent = true })
  end,
}
