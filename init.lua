-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("scripts.insert_path")
require("scripts.lazygit_custom")
require("scripts.search_python_imports")
require("scripts.delete_shadas")
require("scripts.grep_in_neotree_dir")
require("functions.toggle_quickfix")
vim.lsp.set_log_level("info")
