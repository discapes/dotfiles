-- right now I'm using Harper LS
if true then
  return {}
end

-- spellcheck for programmers
return {
  "psliwka/vim-dirtytalk",
  build = ":DirtytalkUpdate",
  event = "BufEnter",
  config = function()
    vim.opt.spelllang = { "en", "programming" }
  end,
}
