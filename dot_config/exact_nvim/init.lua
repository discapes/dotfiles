-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.cmd.colorscheme("retrobox")
vim.o.listchars = "tab:» ,extends:›,precedes:‹,nbsp:!,trail:·" -- ,eol:$
vim.o.showbreak = "↪ " -- how to show wrapped lines
vim.o.commentstring = "#%s" -- what to comment with when the language is not detected
vim.o.wrap = true
vim.o.spell = false -- this is overridden by a LazyVim autocmd
vim.o.spelllang = "" -- use this to disable spellchecking
-- vim.o.expandtab = false
-- vim.o.tabstop = 4
