-- selene: allow(mixed_table)
-- lua/plugins/lsp.lua

-- LSP (Language Server Protocol) configuration
-- Using NEW vim.lsp.config() API (replaces deprecated setup())
-- Compatible with Neovim 0.11.5+

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		require("lsp").setup()
	end,
}
