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
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

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

		-- Gopls config
		vim.lsp.config("gopls", {
			cmd = { "gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			root_dir = function(fname)
				-- Ensure fname is a proper string path
				if type(fname) ~= "string" or fname == "" then
					fname = vim.api.nvim_buf_get_name(0)
				end

				-- Try to find a Go module/workspace or git root
				local found = vim.fs.find({ "go.work", "go.mod", ".git" }, {
					upward = true,
					path = fname,
					stop = vim.loop.os_homedir(),
				})[1]

				if not found then
					-- Fallback: directory of the file, or current working dir
					local dir = vim.fs.dirname(fname)
					if dir and dir ~= "" then
						return dir
					end
					return vim.loop.cwd()
				end

				return vim.fs.dirname(found)
			end,
			capabilities = capabilities,
			settings = {
				gopls = {
					analyses = {
						unusedparams = true,
					},
					staticcheck = true,
					gofumpt = true,
				},
			},
		})

		vim.lsp.enable("gopls")

		-- LspAttach for keymaps (runs when an LSP attaches to a buffer)
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				local bufnr = args.buf

				-- Your LSP keymaps are already in core/keymaps.lua
				-- They will work with any attached LSP
			end,
		})
	end,
}
