local M = {}

function M.setup(capabilities)
	-- config here.
	-- JSON LS with schema store
	vim.lsp.config("jsonls", {
		capabilities = capabilities,
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
				validate = { enable = true },
			},
		},
	})
	vim.lsp.enable("jsonls")
end

return M
