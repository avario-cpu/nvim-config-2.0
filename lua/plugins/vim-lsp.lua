return {
  {
    "prabirshrestha/vim-lsp",
    dependencies = {
      "mattn/vim-lsp-settings",
    },
    enabled = false,
    config = function()
      -- vim-lsp configuration
      vim.cmd([[
        function! s:on_lsp_buffer_enabled() abort
          setlocal omnifunc=lsp#complete
          setlocal signcolumn=yes
          if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
          nmap <buffer> gd <plug>(lsp-definition)
          nmap <buffer> gs <plug>(lsp-document-symbol-search)
          nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
          nmap <buffer> gr <plug>(lsp-references)
          nmap <buffer> gi <plug>(lsp-implementation)
          nmap <buffer> gt <plug>(lsp-type-definition)
          nmap <buffer> <leader>rn <plug>(lsp-rename)
          nmap <buffer> [g <plug>(lsp-previous-diagnostic)
          nmap <buffer> ]g <plug>(lsp-next-diagnostic)
          nmap <buffer> K <plug>(lsp-hover)
        endfunction

        augroup lsp_install
          au!
          autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
        augroup END
      ]])

      -- Enable debug mode (optional)
      vim.g.lsp_log_verbose = 1
      vim.g.lsp_log_file = vim.fn.expand("~/vim-lsp.log")

      -- Automatically install language servers (requires vim-lsp-settings)
      vim.g.lsp_settings = {
        ["pyls-all"] = {
          workspace_config = {
            pyls = {
              plugins = {
                pycodestyle = { enabled = false },
                mccabe = { enabled = false },
              },
            },
          },
        },
      }
    end,
  },
}
