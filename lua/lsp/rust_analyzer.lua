local M = {}

function M.setup(capabilities)
	-- Rust Analyzer config
	vim.lsp.config("rust_analyzer", {
		capabilities = capabilities,
		settings = {
			["rust-analyzer"] = {
				diagnostics = {
					enable = true,
				},
			},
		},
	})
	vim.lsp.enable("rust_analyzer")
end

return M
