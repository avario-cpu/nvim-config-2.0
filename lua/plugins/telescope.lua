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

    -- Custom entry display for live_grep (unchanged)
    local function custom_entry_display(entry)
      local icons = require("nvim-web-devicons")
      local utils = require("telescope.utils")
      local icon, icon_hl = icons.get_icon(entry.filename, vim.fn.fnamemodify(entry.filename, ":e"))
      local icon_width = vim.fn.strdisplaywidth(icon or " ")

      local transformed_path = utils.transform_path({ path_display = { "smart" } }, entry.filename)
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
        { entry.text:gsub("^%s+", ""), "TelescopeResultsStruct" },
      })
    end

    -- Custom entry maker for live_grep (unchanged)
    local function custom_entry_maker(entry)
      local make_entry = require("telescope.make_entry")
      local new_entry = make_entry.gen_from_vimgrep()(entry)
      new_entry.display = custom_entry_display
      return new_entry
    end

    -- New custom entry display for LSP references
    local function lsp_ref_entry_display(entry)
      local icons = require("nvim-web-devicons")
      local utils = require("telescope.utils")
      local icon, icon_hl = icons.get_icon(entry.filename, vim.fn.fnamemodify(entry.filename, ":e"))
      local icon_width = vim.fn.strdisplaywidth(icon or " ")
      local displayer = require("telescope.pickers.entry_display").create({
        separator = " ",
        items = {
          { width = icon_width },
          { width = 40 },
          { width = 8 },
          { remaining = true },
        },
      })
      local transformed_path = utils.transform_path({ path_display = { "smart" } }, entry.filename)
      return displayer({
        { icon or " ", icon_hl },
        { transformed_path, "TelescopeResultsStruct" },
        { entry.lnum .. ":" .. entry.col, "TelescopeResultsNumber" },
        { (entry.text or ""):gsub("^%s+", ""), "TelescopeResultsStruct" },
      })
    end

    -- New custom entry maker for LSP references
    local function lsp_ref_entry_maker(entry)
      local make_entry = require("telescope.make_entry")
      local new_entry = make_entry.gen_from_quickfix()(entry)
      new_entry.display = lsp_ref_entry_display
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
        layout_strategy = "vertical",
        layout_config = {
          width = 0.8,
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
        layout_strategy = "vertical",
        layout_config = {
          width = 0.8,
          height = 0.9,
        },
        entry_maker = lsp_ref_entry_maker,
      }, lsp_references_opts or {})
      old_lsp_references(lsp_references_opts)
    end

    -- Apply smart path display to all pickers
    opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
      path_display = { "smart" },
    })

    return opts
  end,
}
