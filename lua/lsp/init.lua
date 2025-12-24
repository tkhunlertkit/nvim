-- lua/plugins/lsp/init.lua

local M = {}

function M.setup()
	-- Use vim.lsp.enable() with capabilities INSTEAD of deprecated .setup()
	local servers = {
		"lua_ls",
		"pyright",
		"ts_ls",
		"jsonls",
		"yamlls",
		"gopls",
		"rust_analyzer",
		"bashls",
		"sqlls",
		"html",
		"cssls",
	}

	-- Enable all servers
	for _, server in ipairs(servers) do
		vim.lsp.enable(server)
	end

	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	-- Per-language configs
	require("lsp.lua_ls").setup(capabilities)
	require("lsp.jsonls").setup(capabilities)
	require("lsp.yamlls").setup(capabilities)
	require("lsp.ts_ls").setup(capabilities)
	require("lsp.rust_analyzer").setup(capabilities)
	require("lsp.sqlls").setup(capabilities)
	require("lsp.gopls").setup(capabilities)
	require("lsp.pyright").setup(capabilities)

	-- Global LspAttach for keymaps, etc.
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			local bufnr = args.buf

			-- Your LSP keymaps are already in core/keymaps.lua
			-- They will work with any attached LSP
		end,
	})
end

return M
