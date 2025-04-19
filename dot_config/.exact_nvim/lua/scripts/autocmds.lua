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

--vim.api.nvim_create_autocmd("BufWritePost", {
--	pattern = { vim.fn.expand("~") .. "/.local/share/chezmoi/*" },
--	callback = function()
--		print("Applying chezmoi changes...")
--		local filepath = vim.fn.expand("%:p")
--		-- it would be faster to apply just the specific file, but
--		-- we need chezmoi to execute scripts like run_reload_kitty.sh.tmpl
--		-- when we edit kitty.conf so we need to apply the whole config
--		-- vim.fn.jobstart({ "chezmoi", "apply", "--source-path", filepath }, {
--		vim.fn.jobstart({ "chezmoi", "apply" }, {
--			detach = true,
--		})
--	end,
--})

vim.api.nvim_create_user_command("DiffOrig", function()
	local scratch_buffer = vim.api.nvim_create_buf(false, true)
	local current_ft = vim.bo.filetype
	vim.cmd("vertical sbuffer" .. scratch_buffer)
	vim.bo[scratch_buffer].filetype = current_ft
	vim.cmd("read ++edit #") -- load contents of previous buffer into scratch_buffer
	vim.cmd.normal('1G"_d_') -- delete extra newline at top of scratch_buffer without overriding register
	vim.cmd.diffthis() -- scratch_buffer
	vim.cmd.wincmd("p")
	vim.cmd.diffthis() -- current buffer
end, {})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
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
