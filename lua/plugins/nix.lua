local function is_windows()
	return vim.uv.os_uname().sysname == "Windows_NT"
end

return {
	{
		import = "lazyvim.plugins.extras.lang.nix",
		enabled = not is_windows(),
	},
}
