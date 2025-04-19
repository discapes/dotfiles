-- we want to see changes from HEAD so we enable gitsigns,
-- but also mini.diff so we can see changes from the saved version with <leader>go
return {
  {
    "mini.diff",
    opts = function(_, opts)
      opts.source = require("mini.diff").gen_source.save()
    end,
  },
  {
    "gitsigns.nvim",
    -- we need to explicitly enable this, because lazy disabled
    -- gitsigns when mini-diff is enabled
    enabled = true,
  },
}
