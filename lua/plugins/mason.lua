-- selene: allow(mixed_table)
-- ============================================================================
-- Mason: LSP/DAP/Linter/Formatter installer
-- Portable package manager for Neovim that installs LSP servers, DAP servers,
-- linters, and formatters
-- ============================================================================

return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate" },
	build = ":MasonUpdate",
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
				border = "rounded",
			},
		})

		mason_lspconfig.setup({
			-- List of servers to automatically install
			ensure_installed = {
				"lua_ls", -- Lua
				"pyright", -- Python
				"ts_ls", -- TypeScript/JavaScript
				"gopls", -- Go
				"rust_analyzer", -- Rust
				"bashls", -- Bash
				"jsonls", -- JSON
				"yamlls", -- YAML
				"html", -- HTML
				"cssls", -- CSS
				"tailwindcss", -- Tailwind CSS
				"dockerls", -- Docker
				"marksman", -- Markdown
			},
			-- Auto-install servers configured in lspconfig
			automatic_installation = true,
		})
	end,
}
