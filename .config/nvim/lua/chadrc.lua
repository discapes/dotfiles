-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  -- ayu_dark is best
  theme = "ayu_dark",
  transparency = true,

  nvdash = {
    load_on_startup = false,
  },

  hl_override = {
    Comment = { fg = "blue" },
    Visual = { bg = "light_grey" },
    ["@comment"] = { fg = "teal" },
    LineNr = { fg = "light_grey" },
  },
}

return M
