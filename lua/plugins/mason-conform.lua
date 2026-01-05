-- selene: allow(mixed_table)
-- lua/plugins/mason-conform.lua

return {
	"zapling/mason-conform.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"stevearc/conform.nvim",
	},
	config = function()
		require("mason-conform").setup({
			-- Automatically install any formatter configured in conform
			automatic_installation = true,
			-- Optional: explicitly ensure some tools
			-- ensure_installed = { "stylua", "prettier", "black", "isort", "shfmt" },
		})
	end,
}
