-- so we can see hidden files in the file explorer
-- and file picker. use I to toggle ignored files in
-- the explorer
return {
  "snacks.nvim",
  opts = {
    picker = {
      hidden = true,
      sources = {
        explorer = {
          layout = {
            layout = {
              width = 25,
            },
          },
        },
        files = {
          hidden = true,
        },
      },
    },
  },
}
