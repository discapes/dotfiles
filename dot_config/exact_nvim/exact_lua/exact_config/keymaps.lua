-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local map = vim.keymap.set
-- disable arrowkeys
map({ "n", "i", "v" }, "<Left>", "<Nop>")
map({ "n", "i", "v" }, "<Right>", "<Nop>")
map({ "n", "i", "v" }, "<Up>", "<Nop>")
map({ "n", "i", "v" }, "<Down>", "<Nop>")
map({ "n", "i", "v" }, "<PageUp>", "<Nop>")
map({ "n", "i", "v" }, "<PageDown>", "<Nop>")
--
map("n", "<leader>L", "<cmd>LazyExtras<cr>", { desc = "LazyExtras" })
map("n", "<leader>cL", function()
  local filetype = vim.bo.filetype
  local linters = require("lint").linters_by_ft[filetype]

  if linters then
    print("Linters for " .. filetype .. ": " .. table.concat(linters, ", "))
  else
    print("No linters configured for filetype: " .. filetype)
  end
end, { desc = "Show active linters" })

-- surround
map("x", "gsm", ":<C-U>lua MiniSurround.add('visual')<CR>?```<CR>```<CR>gv<gv")
-- map("x", "gsm", "gsa?```<CR>```<CR>gv<", { remap = true }) can't use remap here since somehow autopairs? makes it ```` instead of ```
-- another thing to note is that not using remap means you need to gv after <
map("x", "gsc", "<<<gsmo<Esc>kAsh<Esc>", { remap = true })
map("n", "gsc", "Vgsc", { remap = true })

-- map("n", "<Esc>", "<C-h>", { remap = true })
-- map("n", "<Esc>", function()
--   for i = 1, 3 do
--     vim.cmd.wincmd("w")
--     if vim.bo.filetype == "snacks_layout_box" then
--       break
--     end
--   end
-- end)

-- map("n", "<leader>ue", function toggletransparency()
--   -- if colorscheme startswith tokyonight, theyn w
