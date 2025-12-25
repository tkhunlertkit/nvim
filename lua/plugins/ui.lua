-- lua/plugins/ui.lua
-- UI enhancements: colorscheme, statusline, indentation guides, etc.

return {
	-- Nord Colorscheme
	{
		"arcticicestudio/nord-vim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("nord")
			vim.opt.termguicolors = true
		end,
	},

	-- Icons
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
	},

	-- Dashboard (startup screen)
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("dashboard").setup({
				theme = "doom",
				config = {
					header = {
						"",
						"███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
						"████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
						"██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
						"██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
						"██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
						"╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
						"",
					},
					center = {
						{ icon = "󰈞  ", desc = "Find File", action = "Telescope find_files", key = "f" },
						{ icon = "󰊢  ", desc = "Find Text", action = "Telescope live_grep", key = "g" },
						{ icon = "  ", desc = "Recent Files", action = "Telescope oldfiles", key = "r" },
						{ icon = "󰙅  ", desc = "Exit Neovim", action = "qa", key = "q" },
					},
					footer = {},
				},
			})
		end,
	},
}
