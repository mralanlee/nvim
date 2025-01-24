return {
  "mfussenegger/nvim-lint",
  config = function()
    require("lint").linters_by_ft = {
      python = { "pylint" },
      lua = { "luacheck" },
      javascript = { "eslintd" },
      puppet = { "puppet-lint" }
    }

    vim.api.nvim_create_autocmd({"BufWritePost"}, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
