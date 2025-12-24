local M = {}

function M.setup(capabilities)
	-- Special Lua LS config
	vim.lsp.config("lua_ls", {
		capabilities = capabilities,
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				diagnostics = { globals = { "vim" } },
				workspace = {
					checkThirdParty = false,
					library = { vim.env.VIMRUNTIME },
				},
			},
		},
	})
	vim.lsp.enable("lua_ls")
end

return M
