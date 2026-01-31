return {
	{
		"mfussenegger/nvim-lint",
		opts = {
			linters = {
				["markdownlint-cli2"] = {
					prepend_args = { "--config", "../../.markdownlint-cli2.yaml", "--" },
				},
			},
		},
	},
}
