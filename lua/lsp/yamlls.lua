local M = {}

function M.setup(capabilities)
	-- YAML LS with schema store
	vim.lsp.config("yamlls", {
		capabilities = capabilities,
		settings = {
			yaml = {
				validate = true,
				schemaStore = {
					enable = true,
					url = "https://www.schemastore.org/api/json/catalog.json",
				},
			},
		},
	})
	vim.lsp.enable("yamlls")
end

return M
