return {
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
        nix = { "nixfmt" },
        terraform = { "tofu_fmt" }, -- tflint
        tf = { "tofu_fmt" }, -- tflint
        just = { "just" },
      },
    },
  },
}
