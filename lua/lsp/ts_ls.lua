local M = {}

function M.setup(capabilities)
	-- TypeScript LS config
	vim.lsp.config("ts_ls", {
		capabilities = capabilities,
		init_options = {
			preferences = {
				disableSuggestions = false,
			},
		},
	})
	vim.lsp.enable("ts_ls")
end

return M
