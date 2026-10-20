return {
	"christoomey/vim-tmux-navigator",
	cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
		"TmuxNavigatePrevious",
	},
	keys = {
		{ "<C-h>", "<cmd>TmuxNavitageLeft<cr>" },
		{ "<C-j>", "<cmd>TmuxNavitageDown<cr>" },
		{ "<C-k>", "<cmd>TmuxNavitageUp<cr>" },
		{ "<C-l>", "<cmd>TmuxNavitageRight<cr>" },
		{ "<C-\\>", "<cmd>TmuxNavitagePrevious<cr>" },
	},
}
