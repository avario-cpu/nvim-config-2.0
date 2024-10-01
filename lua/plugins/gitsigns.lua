return {
  "lewis6991/gitsigns.nvim",
  opts = function(_, opts)
    opts.on_attach = function(buffer)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end

      -- Helper function to set tab-specific keymaps
      local function set_diff_tab_keymaps(new_tab)
        local function set_tab_keymap(mode, lhs, rhs, tab_opts)
          tab_opts = vim.tbl_extend("force", tab_opts or {}, {
            callback = function()
              if vim.api.nvim_get_current_tabpage() == new_tab then
                rhs()
              end
            end,
          })
          vim.keymap.set(mode, lhs, "", tab_opts)
        end

        -- Close tab with q
        set_tab_keymap("n", "q", function()
          vim.cmd("tabclose")
          -- Rebind Ctrl+J and Ctrl+K to their original functions
          vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to window below" })
          vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to window above" })
        end, { desc = "Close diff tab" })

        -- Navigate to next change
        set_tab_keymap("n", "<C-j>", function()
          gs.next_hunk()
          vim.cmd("normal! zz")
        end, { desc = "Next change in diff" })

        -- Navigate to previous change
        set_tab_keymap("n", "<C-k>", function()
          gs.prev_hunk()
          vim.cmd("normal! zz")
        end, { desc = "Previous change in diff" })
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
          local new_tab = vim.api.nvim_get_current_tabpage()
          set_diff_tab_keymaps(new_tab)
        end,
        desc = "Open diff in new tab",
      })

      vim.api.nvim_set_keymap("n", "<leader>ghD", "", {
        noremap = true,
        silent = true,
        callback = function()
          vim.cmd("tabnew")
          vim.cmd("buffer #")
          gs.diffthis("~")
          local new_tab = vim.api.nvim_get_current_tabpage()
          set_diff_tab_keymaps(new_tab)
        end,
        desc = "Open diff with ~ in new tab",
      })

      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
    end
  end,
}
