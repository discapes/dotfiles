return {
  "nvim-lint",
  opts = {
    linters = {
      ["markdownlint-cli2"] = {
        args = {
          "--config",
          function()
            return vim.fs.find(".markdownlint.yaml", { upward = true, path = vim.fn.expand("%:p:h") })[1]
          end,
        },
      },
    },
  },
}
