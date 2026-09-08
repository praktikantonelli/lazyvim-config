return {
	{
		"linux-cultist/venv-selector.nvim",
		opts = {
			search = {
				my_venvs = {
					command = "fd 'Scripts\\\\python.exe$' J:\\pytest_venv --full-path --color never -a",
				},
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		opts = {
			linters_by_ft = {
				python = {
					"pylint",
					"mypy",
					"flake8",
				},
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				pyright = {
					settings = {
						python = {
							analysis = {
								typeCheckingMode = "off",
							},
						},
					},
				},
				ruff = {
					init_options = {
						settings = {
							lint = {
								enable = false,
							},
						},
					},
				},
			},
		},
	},
	"nvim-neotest/neotest",
	opts = {
		adapters = {
			["neotest-python"] = {
				runner = "pytest",

				python = function()
					local venv = vim.env.VIRTUAL_ENV
					if venv then
						return venv .. "\\Scripts\\python.exe"
					end
					return "python"
				end,
			},
		},
	},
}
