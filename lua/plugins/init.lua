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
		{ import = "plugins.ui" },
		{ import = "plugins.lsp" },
		{ import = "plugins.cmp" },
		{ import = "plugins.treesitter" },
		{ import = "plugins.telescope" },
		{ import = "plugins.trouble" },
		{ import = "plugins.editor" },
        -- { import = "plugins.others" },
		{ import = "plugins.conform" },
		{ import = "plugins.fidget" },
		{ import = "plugins.schemastore" },
		{ import = "plugins.which-key" },
		{ import = "plugins.obsession" },
		{ import = "plugins.lualine" },
		{ import = "plugins.noice" },
		{ import = "plugins.vim_notify" },
		{ import = "plugins.indent_blankline" },
		{ import = "plugins.rainbow_delimiters" },

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
