return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    servers = {
      -- we don't want to spellcheck comments
      harper_ls = {
        filetypes = {
          "text",
          "plaintex",
          "typst",
          "gitcommit",
          "markdown",
        },
      },
    },
  },
}
