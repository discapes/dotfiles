return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    views = {
      notify = {
        replace = true,
      },
    },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    routes = {
      {
        view = "cmdline",
        filter = { event = "msg_showmode" },
      },
    },
    presets = {
      long_message_to_split = true,
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    { "rcarriga/nvim-notify", opts = {
      background_colour = "#000000",
    } },
  },
}
