return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      }

      vim.list_extend(opts.ensure_installed, {
        -- LSP servers
        "lua-language-server",
        "gopls",
        "rust-analyzer",

        -- Formatter / Linter
        "luacheck",
        "selene",
        "stylua", -- lua formatter
        "prettier", -- js/ts formatter
        "eslint_d", -- js/ts linter/formatter
        "shfmt", -- shell formatter
        "shellcheck", -- shell linter
      })
    end,
  },

  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()

      -- move cl to cli
      keys[#keys + 1] = { "<leader>cl", false }
      keys[#keys + 1] = { "<leader>cli", "<cmd>LspInfo<cr>", desc = "LspInfo" }

      -- add more lsp keymaps
      keys[#keys + 1] = { "<leader>cla", vim.lsp.buf.add_workspace_folder, desc = "Add Folder" }
      keys[#keys + 1] = { "<leader>clr", vim.lsp.buf.remove_workspace_folder, desc = "Remove Folder" }
      keys[#keys + 1] = {
        "<leader>cll",
        "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>",
        desc = "List Folders",
      }
      keys[#keys + 1] = { "<leader>clh", vim.lsp.codelens.run, desc = "Run Code Lens" }
      keys[#keys + 1] = { "<leader>cld", vim.lsp.codelens.refresh, desc = "Refresh Code Lens" }
      keys[#keys + 1] = { "<leader>cls", "<cmd>LspRestart<cr>", desc = "Restart Lsp" }

      require("which-key").add({
        { "<leader>cl", group = "lsp" },
      })
    end,
    opts = {
      capabilities = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = false,
          },
        },
      },
      codelens = {
        enabled = true,
      },
      diagnostics = { virtual_text = { prefix = "icons" } },
      inlay_hints = { enabled = false },
      ---@type lspconfig.options
      ---@diagnostic disable: missing-fields
      setup = {
        ty = function(_, opts)
          require("lspconfig.configs").ty = {
            default_config = {
              cmd = { "ty", "server" },
              filetypes = { "python" },
              root_dir = require("lspconfig.util").root_pattern("ty.toml", "pyproject.toml", ".git"),
              single_file_support = true,
            },
          }
          require("lspconfig").ty.setup(opts)
          return true
        end,
      },
      servers = {
        lua_ls = {
          single_file_support = true,
          ---@type lspconfig.settings.lua_ls
          settings = {
            Lua = {
              hover = { expandAlias = false },
              type = {
                castNumberToInteger = true,
                inferParamType = true,
              },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                -- enable = false,
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
            },
          },
        },
      },
    },
  },

  {
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "VeryLazy",
    opts = {
      excluded_lsp_clients = {
        "null-ls",
        "jdtls",
        "copilot",
        "rust-analyzer",
        "clangd",
      },
    },
  },
  { import = "plugins.extras.lang" },
}
