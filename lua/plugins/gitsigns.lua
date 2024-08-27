return {
  "lewis6991/gitsigns.nvim",
  opts = function(_, opts)
    opts.on_attach = function(buffer)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end

      -- Center cursor after jumping to hunks
      map("n", "]h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gs.next_hunk()
        end
        vim.cmd("normal! zz")
      end, "Next Hunk")

      map("n", "[h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gs.prev_hunk()
        end
        vim.cmd("normal! zz")
      end, "Prev Hunk")
    end
  end,
}
