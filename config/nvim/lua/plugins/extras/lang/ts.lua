local util = require("util")

return {

  -- Add ``lang`` to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      util.list_insert_unique(opts.ensure_installed, {})
    end,
  },

  -- Add ``server`` and ``formatter`` to mason
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "prettier", "prettierd", "typescript-language-server", "vtsls" })
    end,
  },

  -- Setup lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      -- Provide a stub so LazyVim's typescript extra can safely extend `.settings`
      opts.servers.tsserver = opts.servers.tsserver or { settings = { typescript = {}, javascript = {} } }

      -- Prefer vtsls; enrich with sensible defaults
      opts.servers.vtsls = vim.tbl_deep_extend("force", opts.servers.vtsls or {}, {
        settings = {
          vtsls = {
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
          },
        },
      })

      -- Ensure tsserver does not start if vtsls is used
      opts.setup = opts.setup or {}
      opts.setup.tsserver = function()
        return true -- skip default setup (disables tsserver)
      end
    end,
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
      stop_after_first = true,
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
