require "config.lazy"

vim.cmd "colorscheme retrobox"
vim.cmd "highlight Normal guibg=None"
vim.cmd "highlight SignColumn guibg=None"

-- AUTOCMDS
-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     require("nvim-tree.api").tree.open()
--     vim.cmd "wincmd w"
--   end,
-- })
require "scripts.autocmds"
-- require("scripts.mappings")

vim.api.nvim_create_user_command("DiffOrig", function()
  local scratch_buffer = vim.api.nvim_create_buf(false, true)
  local current_ft = vim.bo.filetype
  vim.cmd("vertical sbuffer" .. scratch_buffer)
  vim.bo[scratch_buffer].filetype = current_ft
  vim.cmd "read ++edit #" -- load contents of previous buffer into scratch_buffer
  vim.cmd.normal '1G"_d_' -- delete extra newline at top of scratch_buffer without overriding register
  vim.cmd.diffthis() -- scratch_buffer
  vim.cmd.wincmd "p"
  vim.cmd.diffthis() -- current buffer
end, {})

-- MAPS
-- LSP
local map = vim.keymap.set
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>") -- save with Ctrl + S
map("n", "<C-l>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<M-t>", "<C-w>w", { desc = "Toggle tree focus" })
map("n", "<Esc>", "<C-w>w", { desc = "Toggle tree focus" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename identifier" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "Show signature help" })
map("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })
map("n", "<leader>i", function()
  vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
end, { desc = "Floating diagnostic" })
map("n", "gr", vim.lsp.buf.references, { desc = "Show references" })

-- Telescope
map(
  "n",
  "<leader>fw",
  "<cmd>Telescope live_grep find_command=rg,--ignore,--hidden prompt_prefix=🔍<cr>",
  { desc = "telescope live grep" }
)
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })

-- OTHER
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>") -- save with Ctrl + S
map("n", "<leader>fm", require("conform").format)
