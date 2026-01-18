return {
	{
		"mason-org/mason-lspconfig.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}

			-- only add nil_ls if on NixOS (neither available nor needed on Windows)
			if vim.fn.executable("nix") == 1 then
				table.insert(opts.ensure_installed, "nil_ls")
			end
		end,
	},
}
