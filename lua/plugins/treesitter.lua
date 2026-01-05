-- ============================================================================
-- Treesitter: Advanced syntax highlighting and code understanding
-- Provides better syntax highlighting, indentation, and text objects
-- ============================================================================

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			event = "VeryLazy",
		},
	},
	config = function()
		local ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
		if not ok then
			vim.notify("nvim-treesitter.configs not found", vim.log.levels.ERROR)
			return
		end
		treesitter_configs.setup({
			-- Install parsers for these languages
			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"query",
				"python",
				"javascript",
				"typescript",
				"tsx",
				"json",
				"html",
				"css",
				"markdown",
				"markdown_inline",
				"bash",
				"go",
				"rust",
				"yaml",
				"toml",
				"regex",
				"dockerfile",
				"gitignore",
			},

			-- Install parsers synchronously (only applied to )
			sync_install = false,

			-- Automatically install missing parsers when entering buffer
			auto_install = true,

			-- List of parsers to ignore installing
			ignore_install = {},

			-- ======================================================================
			-- Highlighting
			-- ======================================================================
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},

			-- ======================================================================
			-- Indentation
			-- ======================================================================
			indent = {
				enable = true,
				disable = { "python" }, -- Python indentation is better handled by vim
			},

			-- ======================================================================
			-- Incremental Selection
			-- ======================================================================
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},

			-- ======================================================================
			-- Text Objects
			-- ======================================================================
			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- Automatically jump forward to textobj
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["ab"] = "@block.outer",
						["ib"] = "@block.inner",
						["al"] = "@loop.outer",
						["il"] = "@loop.inner",
						["ai"] = "@conditional.outer",
						["ii"] = "@conditional.inner",
						["a/"] = "@comment.outer",
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- Add to jumplist
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
						["]a"] = "@parameter.inner",
					},
					goto_next_end = {
						["]F"] = "@function.outer",
						["]C"] = "@class.outer",
						["]A"] = "@parameter.inner",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
						["[a"] = "@parameter.inner",
					},
					goto_previous_end = {
						["[F"] = "@function.outer",
						["[C"] = "@class.outer",
						["[A"] = "@parameter.inner",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
			},
		})

		-- Set foldmethod to use treesitter (only if treesitter is loaded)
		local ts_ok = pcall(require, "nvim-treesitter")
		if ts_ok then
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
			vim.opt.foldenable = false -- Don't fold by default
		end
	end,
}

-- Usage examples:
--
-- Incremental Selection:
--   <C-space> - Init selection / Expand selection
--   <bs>      - Shrink selection
--
-- Text Objects (in visual or operator-pending mode):
--   vif - Select inner function
--   vaf - Select outer function (including def/signature)
--   vic - Select inner class
--   dif - Delete inner function
--   caa - Change outer parameter
--
-- Navigation:
--   ]f - Next function start
--   [f - Previous function start
--   ]c - Next class start
--   [c - Previous class start
--
-- Swap parameters:
--   <leader>a - Swap parameter with next
--   <leader>A - Swap parameter with previous
