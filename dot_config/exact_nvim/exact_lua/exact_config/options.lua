-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
local o = vim.o
-- o.cursorlineopt = "both"
-- o.cursorline = true
-- o.tabstop = 2
-- o.clipboard = "unnamedplus"

-- custom options
o.listchars = "tab:» ,extends:›,precedes:‹,nbsp:·,trail:·" -- ,eol:$
o.showbreak = "↪ " -- how to show wrapped lines
o.commentstring = "#%s" -- what to comment with when the language is not detected
o.wrap = true

-- to disable spellchecking
o.spell = false -- this is overridden by a LazyVim autocmd
o.spelllang = "" -- use this to disable spellchecking

-- what do we do with these?
-- o.autoindent = true
-- o.expandtab = false
-- o.shiftwidth = 0

-- these are already set by LazyVim
-- o.list = true -- show whitespace as specified in o.listchars
-- o.number = true -- show line number column
-- o.relativenumber = true -- relative line numbers
-- o.ignorecase = true -- ignore case in search
-- o.signcolumn = "yes" -- column for signs left of the number column
