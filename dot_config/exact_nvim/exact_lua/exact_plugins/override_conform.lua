return {
  "conform.nvim",
  opts = {
    formatters = {
      ["markdownlint-cli2"] = {
        cwd = function()
          return vim.fn.expand("~") -- https://github.com/DavidAnson/markdownlint-cli2/issues/53
        end,
      },
    },
  },
}
