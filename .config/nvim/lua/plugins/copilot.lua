return {
  "zbirenbaum/copilot.lua",
  event = "VeryLazy",
  config = function()
    require("copilot").setup {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<M-l>",
          accept_word = false,
          accept_line = "<M-L>",
          next = "<M-n>",
          prev = "<M-p>",
          dismiss = "<M-q>",
        },
      },
    }
  end,
}
