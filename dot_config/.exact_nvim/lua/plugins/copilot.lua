return {
	"zbirenbaum/copilot.lua",
	event = "VeryLazy",
	config = function()
		require("copilot").setup({
			suggestion = {
				auto_trigger = true,
				keymap = {
					accept = "<C-k>",
					accept_word = false,
					accept_line = "<M-L>",
					next = "<C-n>",
					prev = "<C-p>",
					dismiss = "<C-q>",
				},
			},
		})
	end,
}
