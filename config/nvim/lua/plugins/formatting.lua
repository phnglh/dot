local util = require("util")

return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      javascript = { "prettierd" },
      javascriptreact = { "prettierd" },
      typescript = { "prettierd" },
      typescriptreact = { "prettierd" },
      json = { "prettierd" },
      yaml = { "prettierd" },
      markdown = { "prettierd" },
      sh = { "shfmt" },
      c = { "uncrustify" },
      cpp = { "uncrustify" },
      xml = { "xmllint" },
    },
    formatters = {
      dprint = {
        condition = function(_, ctx)
          return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
        end,
      },
      uncrustify = {
        condition = function(_self, ctx)
          local paths = vim.fs.find({ "uncrustify.cfg", ".uncrustify.cfg" }, {
            path = ctx.filename,
            upward = true,
          })
          if vim.tbl_isempty(paths) then
            return false
          end
          if not util.executable("uncrustify", true) then
            return false
          end
          vim.env.UNCRUSTIFY_CONFIG = paths[1]
          return true
        end,
      },
    },
  },
}
