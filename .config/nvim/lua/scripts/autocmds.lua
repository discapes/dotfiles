-- open nvim-tree if no or dir argument
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function(data)
    local directory = vim.fn.isdirectory(data.file) == 1
    local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

    if directory then
      vim.cmd.cd(data.file)
    end

    if directory or no_name then
      require("nvim-tree.api").tree.open()
    end
  end,
})

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "hyprland.conf",
  callback = function()
    vim.opt.expandtab = true
  end,
})
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "html",
--   callback = function()
--     if vim.fn.expand("%"):find "code/github/qdm" ~= nil then
--       require("conform").formatters_by_ft.html = { "djlint" }
--     end
--   end,
-- })
