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
      vim.list_extend(opts.ensure_installed, { "prettier", "prettierd" })
    end,
  },

  -- Setup lspconfig
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = function(_, opts)
  --     opts.servers = opts.servers or {}
  --     -- provide a stub so lazyvim's typescript extra can safely extend `.settings`
  --     opts.servers.tsserver = opts.servers.tsserver or { settings = { typescript = {}, javascript = {} } }
  --
  --     -- prefer vtsls; enrich with sensible defaults
  --     opts.servers.vtsls = vim.tbl_deep_extend("force", opts.servers.vtsls or {}, {
  --       settings = {
  --         vtsls = {
  --           enablemovetofilecodeaction = true,
  --           autouseworkspacetsdk = true,
  --         },
  --       },
  --     })
  --
  --     -- ensure tsserver does not start if vtsls is used
  --     opts.setup = opts.setup or {}
  --     opts.setup.ts_ls = function()
  --       return true -- skip default setup (disables tsserver)
  --     end
  --   end,
  -- },

  -- Native TSServer client
  -- {
  --   "pmizio/typescript-tools.nvim",
  --   ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  --   dependencies = { "nvim-lua/plenary.nvim", "nvim-lspconfig" },
  --   opts = function()
  --     local api = require("typescript-tools.api")
  --     return {
  --       single_file_support = false,
  --       settings = {
  --         tsserver_file_preferences = {
  --           includeInlayParameterNameHints = "literals",
  --           includeInlayVariableTypeHints = true,
  --           includeInlayFunctionLikeReturnTypeHints = true,
  --         },
  --       },
  --       -- handlers = {
  --       --   ["textDocument/publishDiagnostics"] = api.filter_diagnostics({
  --       --     6133, -- 'x' is declared but its value is never read
  --       --     6196, -- 'param' is declared but never used
  --       --     80006, -- This may be converted to an async function
  --       --   }),
  --       -- },
  --       -- on_attach = function(client, bufnr)
  --       --   client.server_capabilities.diagnosticProvider = false
  --       -- end,
  --       --
  --     }
  --   end,
  -- },
}
