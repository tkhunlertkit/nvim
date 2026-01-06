-- lua/core/keymaps.lua
-- Keybindings for Neovim 0.11+
-- Uses vim.keymap.set with Lua callbacks instead of :lua require()

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local function desc(description)
	return vim.tbl_extend("force", opts, { desc = description })
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

-- Split windows
map("n", "<leader>sv", "<C-w>v", desc("Split window vertically"))
map("n", "<leader>sh", "<C-w>s", desc("Split window horizontally"))
map("n", "<leader>se", "<C-w>=", desc("Make splits equal size"))

-- Delete without yanking
map("n", "<leader>d", '"_d', desc("Delete without yank"))
map("v", "<leader>d", '"_d', desc("Delete without yank"))

-- Select all
map("n", "<C-a>", "gg<S-v>G", desc("Select all"))

-- ============================================================================
-- Search and Replace
-- ============================================================================

-- Keep search matches centered
map("n", "n", "nzzzv", desc("Next search result (centered)"))
map("n", "N", "Nzzzv", desc("Previous search result (centered)"))

-- Better search and replace
map("n", "<leader>s", ":%s//g<Left><Left>", desc("Search and replace"))
map("v", "<leader>s", ":s//g<Left><Left>", desc("Search and replace in selection"))

-- ============================================================================
-- Leader Key Bindings
-- ============================================================================

-- File operations
map("n", "<leader>w", ":w<CR>", desc("save"))
map("n", "<leader>q", ":q<CR>", desc("close"))
map("n", "<leader>Q", ":qa<CR>", desc("quite all"))
map("n", "<leader>x", "<cmd>x<CR>", desc("Save and quit"))

map("n", "<Esc><Esc>", ":nohlsearch<CR>", desc("Clear search highlights"))

-- Better paste (don't overwrite paste buffer)
map("v", "p", '"_dP', opts)

-- Yank to end of line
map("n", "Y", "y$", opts)

-- ============================================================================
-- Telescope (Fuzzy Finder)
-- ============================================================================

map("n", "<leader>ff", function()
	require("telescope.builtin").find_files()
end, desc("find files"))

map("n", "<leader>fF", function()
	require("telescope.builtin").find_files({
		hidden = true,
		no_ignore = true,
	})
end, desc("find files including hidden files"))

map("n", "<leader>fg", function()
	require("telescope.builtin").live_grep()
end, desc("find in files"))

map("n", "<leader>fb", function()
	require("telescope.builtin").buffers()
end, opts)

map("n", "<leader>fh", function()
	require("telescope.builtin").help_tags()
end, desc("find help"))

map("n", "<leader>fr", function()
	require("telescope.builtin").oldfiles()
end, opts)

map("n", "<leader>fc", function()
	require("telescope.builtin").commands()
end, desc("find commands"))

-- map("n", "<leader>/", function()
--   require("telescope.builtin").current_buffer_fuzzy_find()
-- end, opts)
--
-- ============================================================================
-- NvimTree (File Explorer)
-- ============================================================================

map("n", "<leader>e", function()
	require("nvim-tree.api").tree.toggle()
end, desc("open vim tree"))

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
end, desc("Go to definition"))

-- Go to implementation
map("n", "gi", function()
	vim.lsp.buf.implementation()
end, desc("Go to implementation"))

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
map("n", "<leader>sp", "<cmd>Obsession<cr>", desc("pause session tracking"))
-- Quickly source Session.vim in current dir
map("n", "<leader>ss", "<cmd>source Session.vim<cr>", desc("load session"))

-- ============================================================================
-- Neogen
-- ============================================================================
map("n", "<leader>nf", "<cmd>lua require('neogen').generate()<cr>", desc("generate docstring"))
