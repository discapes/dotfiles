return {
  {
    "catppuccin/nvim",
    opts = {
      -- transparent_background = true,
    },
  },
  { "ellisonleao/gruvbox.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha", -- actually doesn't matter since we use last-color
    },
  },
  {
    "folke/tokyonight.nvim",
    -- opts = {
    --   transparent = true,
    --   styles = {
    --     sidebars = "transparent",
    --     floats = "transparent",
    --   },
    -- },
  },
  {
    "raddari/last-color.nvim",
    dependencies = { "catppuccin/nvim" },
    -- event = "VeryLazy",
    lazy = false,
    config = function()
      local theme = require("last-color").recall() or "default"
      vim.cmd.colorscheme(theme)
    end,
  },
}
