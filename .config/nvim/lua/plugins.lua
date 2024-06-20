return {
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        width = 100,
      },
    },
  },
  {
    "stevearc/conform.nvim",
    -- event = "BufWritePre", -- uncomment for format on save
    opts = require "opts.conform_opts",
  },
  {
    "zapling/mason-conform.nvim",
    dependencies = { "williamboman/mason.nvim", "stevearc/conform.nvim" },
    event = "BufWritePre", -- uncomment for format on save
    config = true,
  },
  {
    "williamboman/mason.nvim",
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      automatic_installation = true,
    },
    dependencies = { "williamboman/mason.nvim" },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "opts.ts_opts",
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = require "opts.nvimtree_opts",
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    opts = require "opts.surround_opts",
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "opts.lspconfig_conf"
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = {
      enabled = function()
        return (("markdown|TelescopePrompt"):find(vim.bo.ft) == nil)
      end,
    },
  },
  {
    "bullets-vim/bullets.vim",
    ft = "markdown",
  },
  {
    "kana/vim-textobj-user",
    event = "VeryLazy",
  },
  {
    "kana/vim-textobj-line",
    event = "VeryLazy",
    dependencies = { "kana/vim-textobj-user" },
  },
  {
    "kana/vim-textobj-entire",
    event = "VeryLazy",
    dependencies = { "kana/vim-textobj-user" },
  },
  -- "wellle/targets.vim"
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    "hrsh7th/cmp-buffer",
    enabled = false,
  },
}
