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
map("n", "<Leader>b", function()
	dap.toggle_breakpoint()
end)
map("n", "<Leader>o", function()
	overseer.toggle()
end)
map("n", "<Leader>R", function()
	overseer.run_template()
end)

local function insert_markdown_link()
	-- check if snacks.nvim's picker is available
	local has_snacks, snacks = pcall(require, "snacks")
	if not has_snacks then
		vim.notify("snacks.nvim is not installed", vim.log.levels.ERROR)
		return
	end

	local cword = vim.fn.expand("<cWORD>")
	-- remove trailing punctuation, control and whitespace characters
	cword = cword:gsub("[%p%c%s]+$", "")
	if cword == "" then
		vim.notify("no word under cursor", vim.log.levels.WARN)
		return
	end

	snacks.picker.files({
		search = cword, -- use current WORD under cursor as default input
		actions = {
			confirm = function(picker, item)
				picker:close()

				if item and item.file then
					local selected_path = item.file
					vim.notify(selected_path, vim.log.levels.INFO)
				end
			end,
		},
	})
end

map("n", "<Leader>rl", function()
	insert_markdown_link()
end)
