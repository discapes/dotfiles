return {
  "nvim-mini/mini.surround",
  opts = {
    -- so we can for example surround code blocks with ```
    -- instead of surrounding each line of the selection
    respect_selection_type = true,
  },
  event = "VeryLazy", -- for keybind to work
}
