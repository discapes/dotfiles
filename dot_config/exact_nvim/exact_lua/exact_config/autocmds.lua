-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function(data)
    local directory = vim.fn.isdirectory(data.file) == 1
    local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

    if directory then
      vim.cmd.cd(data.file)
    end

    -- if directory or no_name then
    --   require("nvim-tree.api").tree.open()
    -- end
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { vim.fn.expand("~") .. "/.local/share/chezmoi/*" },
  callback = function()
    print("Applying chezmoi changes...")
    local filepath = vim.fn.expand("%:p")
    -- it is much faster to apply just the specific file, but if
    -- we want chezmoi to execute scripts like run_reload_kitty.sh.tmpl
    -- when we edit kitty.conf so we need to apply the whole config
    vim.fn.jobstart({ "chezmoi", "apply", "--source-path", filepath }, {
      -- vim.fn.jobstart({ "chezmoi", "apply" }, {
      detach = true,
    })
  end,
})
