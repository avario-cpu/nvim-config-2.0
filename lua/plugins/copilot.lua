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
        accept = "<Tab>",
        accept_word = "<M-l>",
        accept_line = "<M-;>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
    }
    return opts
  end,
}
