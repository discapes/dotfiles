return {
  "kylechui/nvim-surround",
  event = "VeryLazy",
  opts = {
    keymaps = {
      -- insert = "<C-g>s",
      -- insert_line = "<C-g>S",
      insert = "<Nop>",
      insert_line = "<Nop>",
      normal_cur = "yss",
      normal_line = "yS",
      normal_cur_line = "ySS",
      visual = "S",
      visual_line = "gS",
      normal = "öa",
      delete = "öd",
      change = "öc",
      change_line = "cS",
    },
  },
}
