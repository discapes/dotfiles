return {
  "iamcco/markdown-preview.nvim",
  config = function()
    vim.api.nvim_exec2(
      [[
        function MkdpBrowserFn(url)
          execute 'silent ! kitty @ launch --dont-take-focus --bias 40 awrit ' . a:url
        endfunction
      ]],
      {}
    )
    vim.cmd([[do FileType]])

    vim.g.mkdp_theme = "dark"
    vim.g.mkdp_filetypes = { "markdown" }
    vim.g.mkdp_browserfunc = "MkdpBrowserFn"
  end,
}
