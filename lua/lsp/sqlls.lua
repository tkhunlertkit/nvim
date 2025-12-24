local M = {}

function M.setup(capabilities)
	-- SQL LS config
	vim.lsp.config("sqlls", {
		capabilities = capabilities,
		settings = {
			sqlls = {
				connections = {},
			},
		},
	})
	vim.lsp.enable("sqlls")
end

return M
