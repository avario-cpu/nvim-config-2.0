return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  enabled = true,
  opts = function(_, opts)
    opts.suggestion = {
      enabled = true,
      auto_trigger = true,
      hide_during_completion = true,
      debounce = 50,
      keymap = {
        accept = false,
        accept_word = "<M-l>",
        accept_line = "<M-;>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
    }
    opts.copilot_node_command = "node" -- Node.js version must be > 16.x
    opts.server_opts_overrides = {
      settings = {
        advanced = {
          listCount = 10, -- #completions for panel
          inlineSuggestCount = 3, -- #completions for getCompletions
        },
      },
    }

    -- Keep tab default behavior in insert mode
    vim.keymap.set("i", "<Tab>", function()
      if require("copilot.suggestion").is_visible() then
        require("copilot.suggestion").accept()
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
      end
    end, {
      silent = true,
    })
    return opts
  end,
}
