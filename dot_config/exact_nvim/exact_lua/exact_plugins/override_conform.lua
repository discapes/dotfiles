return {
  "conform.nvim",
  opts = {
    formatters_by_ft = {
      -- prettier, ruff, nix, terraform are covered by LazyVim
      just = { "just" },
      xml = { "xmlformatter" },
      htmldjango = { "djlint" },
    },
    formatters = {
      ["markdownlint-cli2"] = {
        cwd = function()
          return vim.fn.expand("~") -- https://github.com/DavidAnson/markdownlint-cli2/issues/53
        end,
      },
    },
  },
}
