-- For copying entry to clipboard
local function yank_command()
  local selection = require("telescope.actions.state").get_selected_entry()
  if selection then
    vim.fn.setreg("+", selection.value)
    print("Yanked to clipboard: " .. selection.value)
  end
end

return {
  "telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-fzf-native.nvim",
    "fannheyward/telescope-coc.nvim", -- Coc extension
  },

  keys = {
    { "<leader>fR", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
    { "<leader>fr", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
    -- { "gR", "<cmd>Telescope coc references<cr>", desc = "Coc References" },
  },

  opts = function(_, opts)
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
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
    local function live_grep_entry_maker(entry)
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

      new_entry.display = function(display_entry)
        local icon, icon_hl = utils.get_devicons(display_entry.filename)
        local icon_width = vim.fn.strdisplaywidth(icon or " ")
        local transformed_path = utils.transform_path({ path_display = custom_path }, display_entry.filename)
        local path_width = vim.fn.strdisplaywidth(transformed_path)
        local line_col = display_entry.lnum .. ":" .. display_entry.col
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
          { (display_entry.text or ""):gsub("^%s+", ""), "TelescopeResultsStruct" },
        })
      end

      return new_entry
    end

    -- Override the live_grep function (unchanged)
    local old_live_grep = builtin.live_grep
    builtin.live_grep = function(live_grep_opts)
      live_grep_opts = vim.tbl_extend("force", {
        attach_mappings = function(_, map)
          map("i", "<C-e>", actions.to_fuzzy_refine)
          map("i", "<C-y>", yank_command)
          map("n", "<C-y>", yank_command)
          return true
        end,
        layout_strategy = "horizontal",
        layout_config = {
          width = 0.85,
          height = 0.9,
        },
        entry_maker = live_grep_entry_maker,
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

    -- Override the command_history function (command search)
    local old_commands = builtin.command_history
    builtin.command_history = function(command_opts)
      command_opts = vim.tbl_deep_extend("force", {
        attach_mappings = function(_, map)
          map("i", "<C-y>", yank_command)
          map("n", "<C-y>", yank_command)
          return true
        end,
        layout_strategy = "horizontal",
        layout_config = {
          width = 0.85,
          height = 0.9,
        },
      }, command_opts or {})
      old_commands(command_opts)
    end

    -- Override the buffers function
    local old_buffers = builtin.buffers
    builtin.buffers = function(buffers_opts)
      buffers_opts = vim.tbl_deep_extend("force", {
        layout_strategy = "vertical",
      }, buffers_opts or {})
      old_buffers(buffers_opts)
    end

    function Lsp_references_no_imports()
      local filter_import = function(entry)
        return not (
          entry.text and entry.text:match(".*%f[%w]import%f[%W].*") or entry.text:match(".*%f[%w]from%f[%W].*")
        )
      end

      builtin.lsp_references({
        layout_strategy = "horizontal",
        layout_config = {
          width = 0.85,
          height = 0.9,
        },
        entry_maker = function(entry)
          local new_entry = lsp_ref_entry_maker(entry)
          if filter_import(new_entry) then
            return new_entry
          end
        end,
      })
    end

    vim.keymap.set("n", "gR", ":lua Lsp_references_no_imports()<CR>", {
      noremap = true,
      silent = true,
      desc = "LSP References (no imports)",
    })

    -- Apply smart path display to all pickers
    opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
      path_display = {
        custom_path,
      },
      layout_config = {
        width = 0.85,
      },
    })

    -- Add coc extension configuration
    opts.extensions = opts.extensions or {}
    opts.extensions.coc = {
      theme = "ivy",
      prefer_locations = true,
      push_cursor_on_edit = true,
      timeout = 3000,
    }

    -- Load the coc extension
    require("telescope").load_extension("coc")
    return opts
  end,

  config = function(_, opts)
    require("telescope").setup(opts)
    require("telescope").load_extension("coc")
  end,
}
