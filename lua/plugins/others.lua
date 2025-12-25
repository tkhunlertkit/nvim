-- lua/plugins/others.lua
-- Additional useful plugins

return {
	-- Gitsigns (Git integration in signs column)
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "▎" },
					change = { text = "▎" },
					delete = { text = "▎" },
					topdelete = { text = "▎" },
					changedelete = { text = "▎" },
					untracked = { text = "▎" },
				},
				current_line_blame = false,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol",
					delay = 1000,
					ignore_whitespace = false,
				},
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil,
				max_file_length = 40000,
				preview_config = {
					border = "single",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
				yadm = {
					enable = false,
				},
			})
		end,
	},

	-- Vim Fugitive (Git commands)
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "GBrowse" },
		dependencies = { "tpope/vim-rhubarb" },
	},

	-- Vim Rhubarb (GitHub integration for Fugitive)
	{
		"tpope/vim-rhubarb",
		lazy = true,
	},

	-- Which-key (show available keybindings)
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup({
				preset = "helix",
				delay = function(ctx)
					return ctx.operator and 1000 or 200
				end,
				plugins = {
					marks = true,
					registers = true,
					spelling = {
						enabled = true,
						suggestions = 20,
					},
					presets = {
						operators = true,
						motions = true,
						text_objects = true,
						windows = true,
						nav = true,
						z = true,
						g = true,
					},
				},
				win = {
					type = "float",
					border = "rounded",
					padding = { 1, 2 },
					title = "Help",
					title_pos = "center",
					zindex = 1000,
				},
				layout = {
					width = { min = 20, max = 50 },
					height = { min = 4, max = 25 },
					spacing = 3,
					align = "left",
				},
				keys = {
					scroll_down = "<C-d>",
					scroll_up = "<C-u>",
				},
				sort = { "local", "order", "group", "alphanum", "mod" },
				expand = 0,
				replace = {
					key = {
						function(key)
							return require("which-key.view").format(key)
						end,
					},
				},
				rules = {},
				show_help = true,
				show_keys = true,
			})
		end,
	},

	-- Auto pairs (auto-complete brackets, quotes, etc.)
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({
				check_ts = true,
				ts_config = {
					lua = { "string" },
					javascript = { "template_string" },
					java = false,
				},
				disable_filetype = { "TelescopePrompt", "vim" },
				fast_wrap = {
					map = "<M-e>",
					chars = { "{", "[", "(", '"', "'" },
					pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
					offset = 0,
					end_key = "$",
					keys = "qwertyuiopzxcvbnmasdfghjkl",
					check_comma = true,
					highlight = "PmenuSel",
					highlight_grey = "LineNr",
				},
			})

			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	-- Session management
	{
		"rmagatti/auto-session",
		lazy = false,
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
				auto_restore_enabled = false,
				auto_session_use_git_branch = true,
				auto_save_enabled = true,
			})
		end,
	},

	-- Oil (file explorer as a buffer)
	{
		"stevearc/oil.nvim",
		cmd = "Oil",
		config = function()
			require("oil").setup({
				columns = { "icon" },
				buf_set_name0 = function(bufnr, bufname)
					vim.api.nvim_buf_set_name(bufnr, bufname)
				end,
				default_file_explorer = false,
				restore_win_options = true,
				skip_confirm_for_simple_edits = false,
				prompt_save_on_select_new_fs = true,
				cleanup_on_quit = false,
				lsp_file_methods = {
					enabled = false,
					timeout_ms = 1000,
					autosave_changes = false,
				},
				constrain_cursor = "editable",
				watch_for_changes = false,
				keymaps = {
					["g?"] = "actions.show_help",
					["<CR>"] = "actions.select",
					["<C-s>"] = "actions.select_vsplit",
					["<C-h>"] = "actions.select_split",
					["<C-t>"] = "actions.select_tab",
					["<C-p>"] = "actions.preview",
					["<C-c>"] = "actions.close",
					["q"] = "actions.close",
					["<C-l>"] = "actions.refresh",
					["-"] = "actions.parent",
					["_"] = "actions.open_cwd",
					["`"] = "actions.cd",
					["~"] = "actions.tcd",
					["gs"] = "actions.change_sort",
					["gx"] = "actions.open_external",
					["g."] = "actions.toggle_hidden",
					["g\\"] = "actions.toggle_trash",
				},
			})
		end,
	},

	-- Substitute text
	{
		"gbprod/substitute.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("substitute").setup({})
		end,
	},

	-- nvim-ufo (code folding)
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					return { "treesitter", "indent" }
				end,
			})
			vim.keymap.set("n", "zR", require("ufo").openAllFolds, { noremap = true, silent = true })
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { noremap = true, silent = true })
		end,
	},
}
