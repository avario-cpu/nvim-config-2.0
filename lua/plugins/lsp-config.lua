return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = {
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
                rope_autoimport = { enabled = true, memory = false }, -- use memory false to avoid old imports path showing up in quickfix
                pylint = { enabled = false }, -- Use standalone
                pyflakes = { enabled = false }, -- Use Ruff instead (incorporates pyflakes checks)
                pycodestyle = { enabled = false },
                mccabe = { enabled = true },
                mypy = { enabled = true },
                jedi_references = { enabled = false }, -- false to avoid duplicate references with pyright
                jedi_definition = { enabled = false }, -- false to avoid duplicate definitions with pyright
              },
            },
          },
          on_attach = function(client, _)
            client.server_capabilities.renameProvider = false -- let pyright handle renames
            client.server_capabilities.documentSymbolProvider = false -- let pyright handle symbols
          end,
        },
        pyright = { -- Using in addition to pylsp because only pyright provides workspace symbols
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
      }
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
        "docformatter",
        "ruff-lsp",
        "pylint",
        "lua-language-server",
        "python-lsp-server",
        "taplo", -- TOML formatter
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
        ["python"] = { "black", "docformatter" },
        ["yaml"] = { "prettier" },
      },
      formatters = {
        args = {
          black = { "--line-length", "88" },
          docformatter = { "--wrap-summaries", "88", "--wrap-descriptions", "88" },
        },
      },
    },
  },
}
