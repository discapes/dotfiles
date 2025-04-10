return {
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		opts = {
			filters = {
				dotfiles = false,
				git_ignored = false,
			},
			sync_root_with_cwd = true,
		},
	},

	"nvim-tree/nvim-web-devicons",
}
