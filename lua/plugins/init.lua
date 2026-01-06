-- selene: allow(mixed_table)
-- lua/plugins/init.lua
-- Plugin manager setup and lazy loading
-- Uses lazy.nvim for modern plugin management

local fn = vim.fn
local uv = vim.uv or vim.loop

-- Bootstrap lazy.nvim
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not uv.fs_stat(lazypath) then
	fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Load plugin specifications
require("lazy").setup({
	spec = {
		{ import = "plugins.mason" },
		{ import = "plugins.mason-conform" },
		{ import = "plugins.cmp" },
		{ import = "plugins.conform" },
		{ import = "plugins.editor" },
		{ import = "plugins.fidget" },
		{ import = "plugins.highlight-undo" },
		{ import = "plugins.indent-blankline" },
		{ import = "plugins.lsp" },
		{ import = "plugins.lualine" },
		{ import = "plugins.neogen" },
		{ import = "plugins.noice" },
		{ import = "plugins.nvim-lint" },
		{ import = "plugins.nvim-notify" },
		{ import = "plugins.obsession" },
		{ import = "plugins.rainbow-delimiters" },
		{ import = "plugins.schemastore" },
		{ import = "plugins.telescope" },
		{ import = "plugins.treesitter" },
		{ import = "plugins.trouble" },
		{ import = "plugins.ui" },
		{ import = "plugins.which-key" },
		{ import = "plugins.dap" },

		-- { import = "plugins.others" },
		-- { import = "plugins.oil_nvim" },
		-- { import = "plugins.sleuth" },
	},
	checker = {
		enabled = true,
		notify = false,
	},
	ui = {
		icons = {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			favorite = "⭐",
			feature = "✨",
			lazy = "😴",
			loaded = "✓",
			not_loaded = "✗",
			plugin = "🔌",
			runtime = "💻",
			source = "📂",
			start = "🚀",
			task = "📋",
			list = {
				"●",
				"➜",
				"★",
				"‒",
			},
		},
	},
})
