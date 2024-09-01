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
    vim.keymap.set(
      "n",
      "<leader>I",
      "<M-L><M-H>",
      { noremap = false, silent = true, desc = "Inital additional cursor " }
    )
    -- Dropoff cursor at current position

    vim.keymap.set("n", "<M-L>", "<Plug>(VM-Add-Cursor-At-Pos)", { noremap = true, silent = true })
    -- Toggle cursors shifting with HJKL
    vim.keymap.set("n", "<M-H>", "<Plug>(VM-Toggle-Mappings)", { noremap = true, silent = true })

    -- Add cursors up/down
    vim.keymap.set("n", "<M-K>", "<Plug>(VM-Add-Cursor-Up)", { noremap = true, silent = true })
    vim.keymap.set("n", "<M-J>", "<Plug>(VM-Add-Cursor-Down)", { noremap = true, silent = true })
  end,
}
