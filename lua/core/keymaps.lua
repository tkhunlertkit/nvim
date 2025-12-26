-- lua/core/keymaps.lua
-- Keybindings for Neovim 0.11+
-- Uses vim.keymap.set with Lua callbacks instead of :lua require()

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local function annotate(base_opts, desc)
	return vim.tbl_extend("force", base_opts, { desc = desc })
end

-- ============================================================================
-- General Navigation & Editor
-- ============================================================================

-- Better window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Better indentation
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Move lines up/down
map("n", "<A-j>", ":m .+1<CR>==", opts)
map("n", "<A-k>", ":m .-2<CR>==", opts)
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Increase width by 5
map("n", "<leader>.", "<cmd>vertical resize +5<cr>", opts)
-- Decrease width by 5
map("n", "<leader>,", "<cmd>vertical resize -5<cr>", opts)
-- Increase height by 5
map("n", "<leader>=", "<cmd>resize +5<cr>", opts)
-- Decrease height by 5
map("n", "<leader>-", "<cmd>resize -5<cr>", opts)
-- Equalize all window panes
map("n", "<leader>+", "<C-w>=", opts)

-- ============================================================================
-- Leader Key Bindings
-- ============================================================================

-- File operations
map("n", "<leader>w", ":w<CR>", annotate(opts, "save"))
map("n", "<leader>q", ":q<CR>", annotate(opts, "close"))
map("n", "<leader>Q", ":qa<CR>", annotate(opts, "quite all"))

map("n", "<Esc><Esc>", ":nohlsearch<CR>", opts)

-- Better paste (don't overwrite paste buffer)
map("v", "p", '"_dP', opts)

-- Yank to end of line
map("n", "Y", "y$", opts)

-- ============================================================================
-- Telescope (Fuzzy Finder)
-- ============================================================================

map("n", "<leader>ff", function()
	require("telescope.builtin").find_files()
end, annotate(opts, "find files"))

map("n", "<leader>fF", function()
	require("telescope.builtin").find_files({
		hidden = true,
		no_ignore = true,
	})
end, annotate(opts, "find files including hidden files"))

map("n", "<leader>fg", function()
	require("telescope.builtin").live_grep()
end, annotate(opts, "find in files"))

map("n", "<leader>fb", function()
	require("telescope.builtin").buffers()
end, opts)

map("n", "<leader>fh", function()
	require("telescope.builtin").help_tags()
end, annotate(opts, "find help"))

map("n", "<leader>fr", function()
	require("telescope.builtin").oldfiles()
end, opts)

map("n", "<leader>fc", function()
	require("telescope.builtin").commands()
end, annotate(opts, "find commands"))

-- map("n", "<leader>/", function()
--   require("telescope.builtin").current_buffer_fuzzy_find()
-- end, opts)
--
-- ============================================================================
-- NvimTree (File Explorer)
-- ============================================================================

map("n", "<leader>e", function()
	require("nvim-tree.api").tree.toggle()
end, annotate(opts, "open vim tree"))

-- ============================================================================
-- LSP (Language Server Protocol)
-- ============================================================================

-- LSP hover documentation
map("n", "K", function()
	vim.lsp.buf.hover()
end, opts)

-- Go to definition
map("n", "gd", function()
	vim.lsp.buf.definition()
end, annotate(opts, "Go to definition"))

-- Go to implementation
map("n", "gi", function()
	vim.lsp.buf.implementation()
end, annotate(opts, "Go to implementation"))

-- Go to references
map("n", "gr", function()
	vim.lsp.buf.references()
end, opts)

-- Rename symbol
map("n", "<leader>rn", function()
	vim.lsp.buf.rename()
end, opts)

-- Code actions
map("n", "<leader>ca", function()
	vim.lsp.buf.code_action()
end, opts)

map("v", "<leader>ca", function()
	vim.lsp.buf.code_action()
end, opts)

-- Show diagnostics
map("n", "<leader>d", function()
	vim.diagnostic.open_float()
end, opts)

-- Navigate diagnostics
map("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
	-- vim.diagnostic.goto_prev()
end, opts)

map("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
	-- vim.diagnostic.goto_next()
end, opts)

-- Set diagnostic signs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- ============================================================================
-- Completion (nvim-cmp)
-- ============================================================================

-- Note: Completion keybindings are configured in lua/plugins/cmp.lua
-- They are defined in the cmp.setup() callback

-- ============================================================================
-- Comment (Comment.nvim)
-- ============================================================================

map("n", "<leader>c<leader>", function()
	require("Comment.api").toggle.linewise.current()
end, opts)

map("x", "<leader>c<leader>", function()
	local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
	vim.api.nvim_feedkeys(esc, "nx", false)
	require("Comment.api").toggle.linewise(vim.fn.visualmode())
end, opts)

-- ============================================================================
-- Obsession
-- ============================================================================
-- Toggle Obsession tracking
map("n", "<leader>sp", "<cmd>Obsession<cr>", annotate(opts, "pause session tracking"))
-- Quickly source Session.vim in current dir
map("n", "<leader>ss", "<cmd>source Session.vim<cr>", annotate(opts, "load session"))

-- ============================================================================
-- Neogen
-- ============================================================================
map("n", "<leader>nf", "<cmd>lua require('neogen').generate()<cr>", annotate(opts, "generate docstring"))
