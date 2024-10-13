local map = vim.keymap.set
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>") -- save with Ctrl + S
map("n", "<C-p>", "<C-i>", { noremap = true }) -- because Ctrl I and tab are the same in terminal emulators, so we use C-p to go back
-- map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")
map({ "n", "i", "v" }, "<Left>", "<Nop>")
map({ "n", "i", "v" }, "<Right>", "<Nop>")
map({ "n", "i", "v" }, "<Up>", "<Nop>")
map({ "n", "i", "v" }, "<Down>", "<Nop>")
map({ "n", "i", "v" }, "<PageUp>", "<Nop>")
map({ "n", "i", "v" }, "<PageDown>", "<Nop>")
map({ "n" }, "ä", ":wincmd w<enter>")
