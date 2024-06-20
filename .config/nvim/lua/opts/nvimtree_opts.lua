local conf = require "nvchad.configs.nvimtree"
return vim.tbl_deep_extend("force", conf, {
  git = {
    enable = true,
    ignore = false,
  },
})
