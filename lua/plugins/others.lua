-- selene: allow(mixed_table)
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

	-- Substitute text
	{
		"gbprod/substitute.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("substitute").setup({})
		end,
	},
}
