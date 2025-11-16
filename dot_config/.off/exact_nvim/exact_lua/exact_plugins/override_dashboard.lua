return {
  "snacks.nvim",
  opts = {
    dashboard = {
      sections = {
        {
          pane = 1,
          {
            section = "terminal",
            cmd = "cat ~/.config/neovim-banner.txt | lolcat -S 1 2>/dev/null",
            height = 6,
            padding = 2,
            indent = 5,
          },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
          enabled = function()
            return vim.bo[vim.api.nvim_win_get_buf(vim.api.nvim_list_wins()[1])].filetype ~= "snacks_layout_box"
          end,
        },
        {
          pane = 1,
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 2 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 2 },
          { section = "keys", gap = 1, padding = 2 },
          { section = "startup" },
          enabled = function()
            return vim.bo[vim.api.nvim_win_get_buf(vim.api.nvim_list_wins()[1])].filetype == "snacks_layout_box"
          end,
        },
        {
          pane = 2,
          enabled = function()
            return vim.bo[vim.api.nvim_win_get_buf(vim.api.nvim_list_wins()[1])].filetype ~= "snacks_layout_box"
          end,
          {
            section = "terminal",
            cmd = "colorscript -e square",
            height = 5,
            padding = 1,
          },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          {
            icon = " ",
            title = "Status",
            section = "terminal",
            cmd = [[fastfetch --config ~/.config/small-fastfetch.json --pipe false | sed '1s/^/\n/;s/([^)]*remaining)//']],
            width = 80,
            height = 11,
            ttl = 5 * 60,
            indent = 3,
          },
        },
      },
    },
  },
}
