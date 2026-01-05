-- selene: allow(mixed_table)
-- lua/plugins/conform.lua

-- Code formatter plugin using conform.nvim
-- Supports multiple languages with gofmt, prettier, stylua, black, etc.

return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				-- Go
				go = { "goimports", "gofmt" },

				-- Lua
				lua = { "stylua" },

				-- Python
				python = { "black", "isort" },

				-- JavaScript/TypeScript
				javascript = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				javascriptreact = { "prettier" },

				-- JSON
				json = { "prettier" },

				-- YAML
				yaml = { "prettier" },

				-- Markdown
				markdown = { "prettier" },

				-- Shell/Bash
				bash = { "shfmt" },
				sh = { "shfmt" },

				-- SQL
				sql = { "sqlfluff" },

				-- HTML/CSS
				html = { "prettier" },
				css = { "prettier" },
			},

			formatters = {
				black = {
					prepend_args = { "--line-length", "120" },
				},
			},

			-- Format on save
			format_on_save = {
				timeout_ms = 1000,
				lsp_fallback = true, -- Use LSP if conform doesn't have formatter
			},

			-- Format options
			default_format_opts = {
				lsp_format = "fallback",
			},

			-- Logging
			log_level = vim.log.levels.ERROR,

			-- Notify on error
			notify_on_error = true,
		})

		-- Keymaps
		local opts = { noremap = true, silent = true }

		-- Format current buffer
		vim.keymap.set({ "n", "v" }, "<leader>fmt", function()
			conform.format({ async = true, lsp_fallback = true })
		end, opts)

		-- Format range in visual mode
		vim.keymap.set("v", "<leader>fmt", function()
			conform.format({ async = true, lsp_fallback = true })
		end, opts)
	end,
}
