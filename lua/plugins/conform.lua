return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      -- Set up formatters by filetype
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        javascript = { "prettier", "prettierd", stop_after_first = true },
        json = { "fixjson" },
        go = { "gofmt", "goimports" },
        hcl = { "hcl" },
        packer = { "packer_fmt" },
        yaml = { "yamlfix", "yamlfmt" }
        -- ...
      },
      -- Run on save or manually
      format_on_save = {
        timeout_ms = 5000,
      },
    })
  end,
}
