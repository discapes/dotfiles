return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Telescope",
  opts = {
    pickers = {
      -- find_files = {
      --   find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' },
      -- },
      grep_string = {
        additional_args = { "--hidden" },
      },
      live_grep = {
        additional_args = { "--hidden" },
      },
    },
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files prompt_prefix=🔍<cr>" },
  },
}
