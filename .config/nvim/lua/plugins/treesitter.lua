return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  build = ":TSUpdate",
  -- made redundant by friendly-snippets
  -- dependencies = { "windwp/nvim-ts-autotag", config = true },
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "bash",
        "markdown",
        "markdown_inline",
        "typescript",
        "javascript",
        "tsx",
        "python",
        "svelte",
        "htmldjango",
        "nix",
        "prisma",
      },

      highlight = {
        enable = true,
        use_languagetree = true,
      },
      indent = { enable = true },
    }
  end,
}
