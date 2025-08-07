local util = require("util")

return {
  -- Add ``lang`` to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      util.list_insert_unique(opts.ensure_installed, {
        "css",
        -- "php",
      })
    end,
  },

  -- Add ``server`` and ``formatter`` to mason
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        --[[Servers]]
        --[[Formatters]]
        "prettierd",
        -- "prettier",
      })
    end,
  },

  -- Setup lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = {},
        -- ts_ls = {
        --   root_dir = function(...)
        --     return require("lspconfig.util").root_pattern(".git")(...)
        --   end,
        -- },
        cssls = {},
        tailwindcss = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
        },
        stylelint_lsp = {}, -- css linter
        -- eslint = {},
        -- intelephense = {},
        emmet_language_server = {},
      },
      setup = {
        -- tsserver = function(_, opts)
        --   require("lazyvim.util").on_attach(function(client, buffer)
        --     if client.name == "tsserver" then
        --       client.server_capabilities.documentFormattingProvider = false
        --       -- stylua: ignore
        --       vim.keymap.set("n", "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", { buffer = buffer, desc = "Organize Imports" })
        --       -- stylua: ignore
        --       vim.keymap.set("n", "<leader>cR", "<cmd>TypescriptRenameFile<CR>", { desc = "Rename File", buffer = buffer })
        --     end
        --     -- if client.name == "eslint" then
        --     --   client.server_capabilities.documentFormattingProvider = true
        --     -- end
        --   end)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
      },
    },
  },

  -- Setup up format with new `conform.nvim`
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ["markdown"] = { { "prettierd", "prettier" } },
        ["markdown.mdx"] = { { "prettierd", "prettier" } },
        ["javascript"] = { { "prettierd", "prettier" } },
        ["javascriptreact"] = { { "prettierd", "prettier" } },
        ["typescript"] = { { "prettierd", "prettier" } },
        ["typescriptreact"] = { { "prettierd", "prettier" } },
        ["html"] = { { "prettierd", "prettier" } },
        ["css"] = { { "prettierd", "prettier" } },
      },
    },
  },

  -- Native TSServer client
  {
    "pmizio/typescript-tools.nvim",
    -- event = { "BufReadPost *.ts,*.tsx,*.js,*.jsx", "BufNewFile *.ts,*.tsx,*.js,*.jsx" },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    dependencies = { "nvim-lua/plenary.nvim", "nvim-lspconfig" },
    opts = {
      -- capabilities = require("lsp").client_capabilities(),
      -- on_attach = require("lsp").on_attach,
      single_file_support = false,
      settings = {
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "literals",
          includeInlayVariableTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
        },
      },
    },
  },
}
