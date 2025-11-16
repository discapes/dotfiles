return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      servers = {
        clangd = {
          mason = false,
        },
        tinymist = {
          settings = {
            formatterMode = "",
          },
        },
      },
    },
  },
  {
    "chomosuke/typst-preview.nvim",
    opts = {
      dependencies_bin = {
        -- these need to be installed
        ["tinymist"] = "tinymist",
        ["websocat"] = "websocat",
      },
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "super-tab",
      },
    },
  },
}
