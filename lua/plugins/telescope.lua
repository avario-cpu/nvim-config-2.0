return {
  "telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-fzf-native.nvim",
  },

  keys = {
    { "<leader>fR", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
    { "<leader>fr", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
  },

  opts = function(_, opts)
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")
    local custom_path = { shorten = {
      len = 3,
      exclude = { -1, -2, -3 },
    } }

    -- Custom entry display for live_grep (unchanged)
    local function custom_entry_display(entry)
      local icons = require("nvim-web-devicons")
      local utils = require("telescope.utils")
      local icon, icon_hl = icons.get_icon(entry.filename, vim.fn.fnamemodify(entry.filename, ":e"))
      local icon_width = vim.fn.strdisplaywidth(icon or " ")

      local transformed_path = utils.transform_path({ path_display = custom_path }, entry.filename)
      local path_width = vim.fn.strdisplaywidth(transformed_path)

      local line_col = entry.lnum .. ":" .. entry.col
      local line_col_width = vim.fn.strdisplaywidth(line_col)

      local displayer = require("telescope.pickers.entry_display").create({
        separator = " ",
        items = {
          { width = icon_width },
          { width = path_width },
          { width = line_col_width },
          { remaining = true },
        },
      })

      return displayer({
        { icon or " ", icon_hl },
        { transformed_path, "TelescopeResultsStruct" },
        { entry.lnum .. ":" .. entry.col, "TelescopeResultsNumber" },
        { (entry.text or ""):gsub("^%s+", ""), "TelescopeResultsStruct" },
      })
    end

    -- Custom entry maker for live_grep (unchanged)
    local function custom_entry_maker(entry)
      local make_entry = require("telescope.make_entry")
      local new_entry = make_entry.gen_from_vimgrep()(entry)
      new_entry.display = custom_entry_display
      return new_entry
    end

    local function lsp_ref_entry_maker(entry)
      local make_entry = require("telescope.make_entry")
      local utils = require("telescope.utils")
      local new_entry = make_entry.gen_from_quickfix()(entry)

      -- Convert absolute path to relative path
      new_entry.filename = vim.fn.fnamemodify(entry.filename, ":.")

      new_entry.display = function(entry)
        local icon, icon_hl = utils.get_devicons(entry.filename)
        local icon_width = vim.fn.strdisplaywidth(icon or " ")
        local transformed_path = utils.transform_path({ path_display = custom_path }, entry.filename)
        local path_width = vim.fn.strdisplaywidth(transformed_path)
        local line_col = entry.lnum .. ":" .. entry.col
        local line_col_width = vim.fn.strdisplaywidth(line_col)

        local displayer = require("telescope.pickers.entry_display").create({
          separator = " ",
          items = {
            { width = icon_width },
            { width = path_width },
            { width = line_col_width },
            { remaining = true },
          },
        })

        return displayer({
          { icon or " ", icon_hl },
          { transformed_path, "TelescopeResultsStruct" },
          { line_col, "TelescopeResultsNumber" },
          { (entry.text or ""):gsub("^%s+", ""), "TelescopeResultsStruct" },
        })
      end

      return new_entry
    end

    -- Override the live_grep function (unchanged)
    local old_live_grep = builtin.live_grep
    builtin.live_grep = function(live_grep_opts)
      live_grep_opts = vim.tbl_extend("force", {
        attach_mappings = function(_, map)
          map("i", "<c-e>", actions.to_fuzzy_refine)
          return true
        end,
        layout_strategy = "horizontal",
        layout_config = {
          width = 0.85,
          height = 0.9,
        },
        entry_maker = custom_entry_maker,
      }, live_grep_opts or {})
      old_live_grep(live_grep_opts)
    end

    -- Override the lsp_references function with new LSP-specific entry maker
    local old_lsp_references = builtin.lsp_references
    builtin.lsp_references = function(lsp_references_opts)
      lsp_references_opts = vim.tbl_deep_extend("force", {
        layout_strategy = "horizontal",
        layout_config = {
          width = 0.85,
          height = 0.9,
        },
        entry_maker = lsp_ref_entry_maker,
      }, lsp_references_opts or {})
      old_lsp_references(lsp_references_opts)
    end

    -- Apply smart path display to all pickers
    opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
      path_display = {
        custom_path,
      },
      layout_config = {
        width = 0.85,
      },
    })

    return opts
  end,
}
