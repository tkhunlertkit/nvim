-- selene: allow(mixed_table)
-- ============================================================================
-- DAP: Debug Adapter Protocol
-- Debug support for Neovim (like VSCode debugger)
-- ============================================================================

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		-- UI for DAP
		{
			"rcarriga/nvim-dap-ui",
			dependencies = { "nvim-neotest/nvim-nio" },
			config = function()
				local dap = require("dap")
				local dapui = require("dapui")

				dapui.setup({
					icons = { expanded = "", collapsed = "", current_frame = "" },
					layouts = {
						{
							elements = {
								{ id = "scopes", size = 0.25 },
								{ id = "breakpoints", size = 0.25 },
								{ id = "stacks", size = 0.25 },
								{ id = "watches", size = 0.25 },
							},
							size = 40,
							position = "left",
						},
						{
							elements = {
								{ id = "repl", size = 0.5 },
								{ id = "console", size = 0.5 },
							},
							size = 10,
							position = "bottom",
						},
					},
				})

				-- Auto-open DAP UI when debugging starts
				dap.listeners.after.event_initialized["dapui_config"] = function()
					dapui.open()
				end
				dap.listeners.before.event_terminated["dapui_config"] = function()
					dapui.close()
				end
				dap.listeners.before.event_exited["dapui_config"] = function()
					dapui.close()
				end
			end,
		},

		-- Virtual text for DAP
		{
			"theHamsta/nvim-dap-virtual-text",
			opts = {},
		},

		-- Mason integration for DAP
		{
			"jay-babu/mason-nvim-dap.nvim",
			dependencies = { "williamboman/mason.nvim" },
			cmd = { "DapInstall", "DapUninstall" },
			opts = {
				ensure_installed = {
					"python",
					"delve", -- Go debugger
				},
				automatic_installation = true,
				handlers = {},
			},
		},
	},
	keys = {
		-- Debug controls
		{ "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>", desc = "Toggle breakpoint" },
		{
			"<leader>dB",
			"<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
			desc = "Conditional breakpoint",
		},
		{ "<leader>dc", "<cmd>lua require('dap').continue()<CR>", desc = "Continue" },
		{ "<leader>di", "<cmd>lua require('dap').step_into()<CR>", desc = "Step into" },
		{ "<leader>do", "<cmd>lua require('dap').step_over()<CR>", desc = "Step over" },
		{ "<leader>dO", "<cmd>lua require('dap').step_out()<CR>", desc = "Step out" },
		{ "<leader>dr", "<cmd>lua require('dap').repl.toggle()<CR>", desc = "Toggle REPL" },
		{ "<leader>dl", "<cmd>lua require('dap').run_last()<CR>", desc = "Run last" },
		{ "<leader>dt", "<cmd>lua require('dap').terminate()<CR>", desc = "Terminate" },

		-- DAP UI
		{ "<leader>du", "<cmd>lua require('dapui').toggle()<CR>", desc = "Toggle DAP UI" },
		{ "<leader>de", "<cmd>lua require('dapui').eval()<CR>", desc = "Eval", mode = { "n", "v" } },
	},
	config = function()
		local dap = require("dap")

		-- Configure signs
		vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
		vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
		vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
		vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticWarn", linehl = "Visual", numhl = "" })

		-- Python configuration
		dap.adapters.python = {
			type = "executable",
			command = "python",
			args = { "-m", "debugpy.adapter" },
		}

		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Launch file",
				program = "",
				pythonPath = function()
					return "/usr/bin/python3"
				end,
			},
		}

		-- Go configuration
		dap.adapters.delve = {
			type = "server",
			port = "",
			executable = {
				command = "dlv",
				args = { "dap", "-l", "127.0.0.1:" },
			},
		}

		dap.configurations.go = {
			{
				type = "delve",
				name = "Debug",
				request = "launch",
				program = "",
			},
			{
				type = "delve",
				name = "Debug test",
				request = "launch",
				mode = "test",
				program = "",
			},
		}
	end,
}
