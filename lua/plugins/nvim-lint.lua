-- lua/plugins/nvim-lint.lua
return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local lint = require("lint")

		-- Define which linters to use per filetype
		lint.linters_by_ft = {
			-- Python
			python = { "ruff" },

			-- JavaScript / TypeScript
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },

			-- YAML
			yaml = { "yamllint" },

			-- Docker
			dockerfile = { "hadolint" },

			-- Lua
			lua = { "selene" },

			-- JSON
			json = { "jsonlint" },

			-- Markdown
			markdown = { "markdownlint" },

			-- Shell
			sh = { "shellcheck" },
			bash = { "shellcheck" },

			-- Go
			go = { "golangci-lint" },

			-- SQL
			sql = { "sqlfluff" },
		}

		-- add this block ↓↓↓
		lint.linters.selene = vim.tbl_deep_extend("force", lint.linters.selene or {}, {
			condition = function(ctx)
				-- look for selene.toml starting from the file and walking upward
				return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1] ~= nil
			end,
		})

		-- Setup autocmd to lint on save and on text change
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		-- Optional: key mapping to manually trigger lint
		vim.keymap.set("n", "<leader>ll", function()
			lint.try_lint()
		end, { noremap = true, silent = true, desc = "Trigger linter" })
	end,
}
