-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("autocmds.shada_delete")
require("scripts.insert_path")
vim.lsp.set_log_level("debug")
