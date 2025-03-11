return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = {
      filters = {
        dotfiles = false,
        git_ignored = false,
      },
    },
  },

  "nvim-tree/nvim-web-devicons",
}
