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

      map("n", "]H", function()
        gs.nav_hunk("last")
      end, "Last Hunk")
      map("n", "[H", function()
        gs.nav_hunk("first")
      end, "First Hunk")
      map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
      map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
      map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
      map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
      map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
      map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
      map("n", "<leader>ghb", function()
        gs.blame_line({ full = true })
      end, "Blame Line")
      map("n", "<leader>ghB", function()
        gs.blame()
      end, "Blame Buffer")

      vim.api.nvim_set_keymap("n", "<leader>ghd", "", {
        noremap = true,
        silent = true,
        callback = function()
          vim.cmd("tabnew")
          vim.cmd("buffer #")
          require("gitsigns").diffthis()
          vim.api.nvim_buf_set_keymap(0, "n", "q", ":tabclose<CR>", { noremap = true, silent = true })
        end,
        desc = "Open diff in new tab",
      })

      map("n", "<leader>ghD", function()
        gs.diffthis("~")
      end, "Diff This ~")
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
    end
  end,
}
