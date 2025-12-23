-- lua/plugins/init.lua
-- Plugin manager setup and lazy loading
-- Uses lazy.nvim for modern plugin management

local fn = vim.fn

-- Bootstrap lazy.nvim
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
		{ import = "plugins.lsp" },
		{ import = "plugins.cmp" },
		{ import = "plugins.treesitter" },
		{ import = "plugins.telescope" },
		{ import = "plugins.ui" },
		{ import = "plugins.editor" },
		--    { import = "plugins.others" },
		{ import = "plugins.conform" },
		{ import = "plugins.fidget" },
		{ import = "plugins.schemastore" },
	},
	install = {
		colorscheme = { "nord" },
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
