-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local dap = require("dap")
local overseer = require("overseer")
map("i", "jj", "<esc>")
map("n", "<F5>", function()
	dap.continue()
end)
map("n", "<F6>", function()
	dap.disconnect({ terminateDebuggee = true })
end)
map("n", "<F10>", function()
	dap.step_over()
end)
map("n", "<F11>", function()
	dap.step_into()
end)
map("n", "<F12>", function()
	dap.step_out()
end)
map("n", "<Leader>o", function()
	overseer.toggle()
end)
map("n", "<Leader>R", function()
	overseer.run_template()
end)

local function relative_path(from_file, target_path)
	local from = vim.split(vim.fs.dirname(vim.fs.normalize(vim.fs.abspath(from_file))), "/", {
		plain = true,
		trimempty = true,
	})

	local to = vim.split(vim.fs.normalize(vim.fs.abspath(target_path)), "/", {
		plain = true,
		trimempty = true,
	})

	local i = 1
	while from[i] and from[i] == to[i] do
		i = i + 1
	end

	local out = {}

	for _ = i, #from do
		out[#out + 1] = ".."
	end

	for j = i, #to do
		out[#out + 1] = to[j]
	end

	return "./" .. table.concat(out, "/")
end

local function word_range_under_cursor(line, word, col)
	local start = 1

	while true do
		local s, e = line:find(word, start, true)
		if not s then
			return nil
		end

		local start_col = s - 1
		local end_col = e

		if start_col <= col and col < end_col then
			return start_col, end_col
		end

		start = e + 1
	end
end

local function insert_markdown_link()
	local ok, snacks = pcall(require, "snacks")
	if not ok then
		vim.notify("snacks.nvim is not installed", vim.log.levels.ERROR)
		return
	end

	local cword = vim.fn.expand("<cWORD>"):gsub("[%p%c%s]+$", "")
	if cword == "" then
		vim.notify("no word under cursor", vim.log.levels.WARN)
		return
	end

	local current_file = vim.api.nvim_buf_get_name(0)
	if current_file == "" then
		vim.notify("current buffer has no file name", vim.log.levels.WARN)
		return
	end

	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local line = vim.api.nvim_get_current_line()
	local start_col, end_col = word_range_under_cursor(line, cword, col)

	if start_col == nil or end_col == nil then
		vim.notify("could not find word under cursor", vim.log.levels.ERROR)
		return
	end

	snacks.picker.files({
		search = cword,

		actions = {
			confirm = function(picker, item)
				picker:close()

				if not item or not item.file then
					return
				end

				local rel_path = relative_path(current_file, tostring(item.file))
				local link = ("[%s](%s)"):format(cword, rel_path)

				vim.api.nvim_buf_set_text(0, row - 1, start_col, row - 1, end_col, { link })
				vim.api.nvim_win_set_cursor(0, { row, start_col + #link })
			end,
		},
	})
end

map("n", "<Leader>rl", insert_markdown_link, { desc = "Insert rel. link under cursor" })
