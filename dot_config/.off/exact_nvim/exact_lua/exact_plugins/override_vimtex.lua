return {
  "lervag/vimtex",
  init = function()
    -- see https://github.com/lervag/vimtex/blob/be9deac3a23eeb145ccf11dd09080795838496ce/doc/vimtex.txt#L6039
    -- sioyek works best ootb with both forward and inverse search on macOS
    vim.g.vimtex_view_method = "sioyek"
    local group = vim.api.nvim_create_augroup("vimtex", {})
    vim.api.nvim_create_autocmd("User", {
      pattern = "VimtexEventViewReverse",
      group = group,
      callback = function()
        vim.system({ "aerospace", "focus", "left" })
      end,
    })
  end,
}
