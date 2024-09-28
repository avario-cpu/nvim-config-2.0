return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local keys = require("lazyvim.plugins.lsp.keymaps").get()

      -- Find and modify the "]]" keymap to "]r"
      for i, keymap in ipairs(keys) do
        if keymap[1] == "]]" then
          keys[i] = {
            "]r",
            function()
              LazyVim.lsp.words.jump(vim.v.count1)
            end,
            desc = "Next Reference",
            has = "documentHighlight",
            cond = function()
              return LazyVim.lsp.words.enabled
            end,
          }
          break
        end
      end

      -- Find and modify the "[[" keymap to "[r"
      for i, keymap in ipairs(keys) do
        if keymap[1] == "[[" then
          keys[i] = {
            "[r",
            function()
              LazyVim.lsp.words.jump(-vim.v.count1)
            end,
            desc = "Prev Reference",
            has = "documentHighlight",
            cond = function()
              return LazyVim.lsp.words.enabled
            end,
          }
          break
        end
      end

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
          autostart = true,
          settings = {
            pylsp = {
              plugins = {
                rope_autoimport = { enabled = true, memory = false }, -- use memory false to avoid old imports path showing up in quickfix
                pylint = { enabled = true, executable = "pylint" },
                pyflakes = { enabled = false }, -- Use Ruff instead (incorporates pyflakes checks)
                pycodestyle = { enabled = false },
                mccabe = { enabled = true },
                mypy = { enabled = true },
                jedi_references = { enabled = false },
                jedi_definition = { enabled = false },
                -- pylsp_rope = { rename = true },
                -- pylsp_rope = {
                --   rename = true,
                -- },
                -- Disable other rename providers
                -- rope_rename = { enabled = false },
                -- jedi_rename = { enabled = false },
              },
            },
          },
          -- cmd = { "pylsp" },
          on_attach = function(client, _)
            -- Some pylsp features are disabled to avoid duplicates with pyright
            client.server_capabilities.renameProvider = true
            client.server_capabilities.documentSymbolProvider = false

            vim.lsp.handlers["textDocument/references"] = vim.lsp.with(vim.lsp.handlers.references, {
              includeDeclaration = true,
            })
          end,
        },
        pyright = { -- Only pyright provides workspace symbols
          autostart = true,
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
          on_attach = function(client, _)
            client.server_capabilities.signatureHelpProvider = false
            client.server_capabilities.referencesProvider = true
            client.server_capabilities.renameProvider = false
            -- client.server_capabilities.definitionProvider = false
          end,
        },
        -- ruff_lsp = {
        --   autostart = false, -- I think there is a server starting with ruff standalone, which covers the same functionality
        -- },
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
        "ruff",
        "docformatter",
        -- "ruff-lsp",
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
        ["python"] = { "ruff_format" },
        ["yaml"] = { "prettier" },
      },
      formatters = {
        args = {
          ruff_format = { "--line-length", "88" },
        },
      },
    },
  },
}
