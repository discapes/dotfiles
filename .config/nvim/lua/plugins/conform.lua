return {
  {
    "zapling/mason-conform.nvim",
    dependencies = { "williamboman/mason.nvim", "stevearc/conform.nvim" },
    event = "BufWritePre", -- uncomment for format on save
    config = true,
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = {
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        lua = { "stylua" },
        css = { "prettier" },
        html = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        xml = { "xmlformat" },
        python = { "black" },
        htmldjango = { "djlint" },
        nix = { "nixpkgs_fmt" },
        terraform = { "terraform_fmt" }, -- tflint
        tf = { "terraform_fmt" }, -- tflint
      },
    },
  },
}
