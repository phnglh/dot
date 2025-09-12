return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufWritePost", "InsertLeave" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      lua = { "selene", "luacheck" },
      javascript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      sh = { "shellcheck" },
      python = { "ruff" },
      json = { "jsonlint" },
      yaml = { "yamllint" },
      markdown = { "markdownlint" },
    }

    -- helper để bọc condition
    local function conditional_linter(name, condition)
      local orig = lint.linters[name]
      if not orig then
        return
      end
      local fn = vim.deepcopy(orig)
      fn.condition = condition
      lint.linters[name] = fn
    end

    -- Lua
    conditional_linter("selene", function(ctx)
      return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
    end)

    conditional_linter("luacheck", function(ctx)
      return vim.fs.find({ ".luacheckrc" }, { path = ctx.filename, upward = true })[1]
    end)

    -- JavaScript/TypeScript (eslint_d chỉ chạy khi có config)
    conditional_linter("eslint_d", function(ctx)
      local package_json = vim.fs.find({ "package.json" }, { path = ctx.filename, upward = true })[1]
      if package_json then
        local f = io.open(package_json, "r")
        if f then
          local data = vim.json.decode(f:read("*all"))
          f:close()
          if data and data.eslintConfig then
            return true
          end
        end
      end
      return vim.fs.find({
        ".eslintrc",
        ".eslintrc.js",
        ".eslintrc.cjs",
        ".eslintrc.json",
        "eslint.config.mjs",
      }, { path = ctx.filename, upward = true })[1]
    end)

    -- Python (ruff -> lint + format, nhưng ở đây ta chỉ dùng lint)
    conditional_linter("ruff", function(ctx)
      return vim.fs.find({ "pyproject.toml", "ruff.toml", ".ruff.toml" }, {
        path = ctx.filename,
        upward = true,
      })[1]
    end)

    -- Shell (shellcheck luôn có thể chạy, không cần config)
    -- JSON/YAML/Markdown cũng vậy, thường global lint

    -- Auto lint on save/insert leave
    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
