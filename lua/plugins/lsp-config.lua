return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {

        powershell_es = {
          mason = true,
          settings = {
            powershell = {
              scriptAnalysis = { enable = true },
              codeFormatting = { preset = "OTBS" },
            },
          },
        },

        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                rope_autoimport = { enabled = true },
                pylint = { enabled = false }, -- Use stanandalone
                pyflakes = { enabled = false }, -- Use pyright
                pycodestyle = { enabled = false },
                mccabe = { enabled = true },
                mypy = { enabled = false },
                jedi_references = { enabled = false }, -- to avoid duplicate references with pyright
              },
            },
          },
        },

        pyright = {
          priority = 1,
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                typeCheckingMode = "basic",
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
              },
            },
          },
        },

        ruff_lsp = {},
        yamlls = {},
      },
    },
    on_attach = function(_, bufnr)
      -- Set up the keybinding for organizing imports
      vim.keymap.set("n", "<leader>ro", function()
        local params = {
          command = "_ruff.organizeImports",
          arguments = { vim.uri_from_bufnr(0) },
        }
        vim.lsp.buf.execute_command(params)
      end, { buffer = bufnr, desc = "Organize Imports" })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "pyright",
        "powershell-editor-services",
        "black",
        "ruff-lsp",
        "mypy",
        "pylint",
        "lua-language-server",
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "powershell" })
      end
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["powershell"] = { "powershell_es" },
        ["python"] = { "black" },
        ["yaml"] = { "prettier" },
        ["json"] = { "prettier" },
      },
    },
  },
}
