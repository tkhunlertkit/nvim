-- selene: allow(mixed_table)
-- lua/plugins/treesitter.lua - MINIMAL VERSION (No textobjects)
-- Treesitter configuration without textobjects to avoid loading issues

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter").setup({
				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				auto_install = true,

				-- List of parsers to install
				ensure_installed = {
					"bash",
					"c",
					"cpp",
					"css",
					"go",
					"html",
					"javascript",
					"json",
					"lua",
					"markdown",
					"markdown_inline",
					"python",
					"regex",
					"rust",
					"sql",
					"tsx",
					"typescript",
					"vim",
					"vimdoc",
					"yaml",
				},

				-- Highlighting configuration
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},

				-- Indentation based on treesitter
				indent = {
					enable = true,
				},

				-- Incremental selection
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
			})
		end,
	},
}
