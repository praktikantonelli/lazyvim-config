return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"mason-org/mason.nvim",
	},
	config = function()
		local dap = require("dap")
		local codelldb_bin = vim.fn.exepath("codelldb")

		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				-- Change this to your path!
				command = codelldb_bin,
				args = { "--port", "${port}" },
			},
		}

		dap.configurations.rust = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,

				sourceLanguages = { "rust" },
			},
		}
		local dapui = require("dapui")

		dapui.setup()

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })
	end,
}
