-- ============================================================================
-- Core Keymaps
-- Global key mappings using modern vim.keymap.set API
-- ============================================================================

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ============================================================================
-- Helper function for description
-- ============================================================================
local function desc(description)
  return vim.tbl_extend("force", opts, { desc = description })
end

-- ============================================================================
-- General Mappings
-- ============================================================================

-- Better escape (jk to exit insert mode)
map("i", "jk", "<ESC>", desc("Exit insert mode"))

-- Toggle paste mode for safe pasting
map("n", "<leader>p", function()
  vim.opt.paste = not vim.opt.paste:get()
  local status = vim.opt.paste:get() and "enabled" or "disabled"
  vim.notify("Paste mode " .. status, vim.log.levels.INFO)
end, desc("Toggle paste mode"))

-- Save and quit
map("n", "<leader>w", "<cmd>w<CR>", desc("Save file"))
map("n", "<leader>q", "<cmd>q<CR>", desc("Quit"))
map("n", "<leader>Q", "<cmd>qa<CR>", desc("Quit all"))
map("n", "<leader>x", "<cmd>x<CR>", desc("Save and quit"))

-- Clear search highlights
map("n", "<Esc><Esc>", "<cmd>nohl<CR>", desc("Clear search highlights"))

-- Better window navigation
map("n", "<C-h>", "<C-w>h", desc("Go to left window"))
map("n", "<C-j>", "<C-w>j", desc("Go to bottom window"))
map("n", "<C-k>", "<C-w>k", desc("Go to top window"))
map("n", "<C-l>", "<C-w>l", desc("Go to right window"))

-- Resize windows with arrows
map("n", "<C-Up>", "<cmd>resize +2<CR>", desc("Increase window height"))
map("n", "<C-Down>", "<cmd>resize -2<CR>", desc("Decrease window height"))
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", desc("Decrease window width"))
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", desc("Increase window width"))

-- Split windows
map("n", "<leader>sv", "<C-w>v", desc("Split window vertically"))
map("n", "<leader>sh", "<C-w>s", desc("Split window horizontally"))
map("n", "<leader>se", "<C-w>=", desc("Make splits equal size"))
map("n", "<leader>sx", "<cmd>close<CR>", desc("Close current split"))
map("n", "<leader>=", "<C-w>=", desc("Make splits equal size"))

-- ============================================================================
-- Buffer Management
-- ============================================================================
map("n", "<Tab>", "<cmd>bnext<CR>", desc("Next buffer"))
map("n", "<S-Tab>", "<cmd>bprevious<CR>", desc("Previous buffer"))
map("n", "<leader>bd", "<cmd>bdelete<CR>", desc("Delete buffer"))
map("n", "<leader>ba", "<cmd>%bd|e#|bd#<CR>", desc("Delete all buffers except current"))

-- ============================================================================
-- Text Editing
-- ============================================================================

-- Move text up and down
map("n", "<A-j>", "<cmd>m .+1<CR>==", desc("Move line down"))
map("n", "<A-k>", "<cmd>m .-2<CR>==", desc("Move line up"))
map("v", "<A-j>", ":m '>+1<CR>gv=gv", desc("Move selection down"))
map("v", "<A-k>", ":m '<-2<CR>gv=gv", desc("Move selection up"))

-- Better indenting (maintains selection)
map("v", "<", "<gv", desc("Indent left"))
map("v", ">", ">gv", desc("Indent right"))

-- Stay in indent mode
map("v", "<Tab>", ">gv", desc("Indent right"))
map("v", "<S-Tab>", "<gv", desc("Indent left"))

-- Paste without yanking in visual mode
map("v", "p", '"_dP', desc("Paste without yank"))

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
-- Quick Fix / Location List
-- ============================================================================
map("n", "<leader>co", "<cmd>copen<CR>", desc("Open quickfix"))
map("n", "<leader>cc", "<cmd>cclose<CR>", desc("Close quickfix"))
map("n", "[q", "<cmd>cprev<CR>", desc("Previous quickfix"))
map("n", "]q", "<cmd>cnext<CR>", desc("Next quickfix"))

map("n", "<leader>lo", "<cmd>lopen<CR>", desc("Open location list"))
map("n", "<leader>lc", "<cmd>lclose<CR>", desc("Close location list"))
map("n", "[l", "<cmd>lprev<CR>", desc("Previous location"))
map("n", "]l", "<cmd>lnext<CR>", desc("Next location"))

-- ============================================================================
-- Terminal
-- ============================================================================
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc("Toggle floating terminal"))
map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", desc("Toggle horizontal terminal"))
map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", desc("Toggle vertical terminal"))

-- ============================================================================
-- Diagnostic Navigation
-- ============================================================================
map("n", "[d", vim.diagnostic.goto_prev, desc("Previous diagnostic"))
map("n", "]d", vim.diagnostic.goto_next, desc("Next diagnostic"))
map("n", "<leader>df", vim.diagnostic.open_float, desc("Show diagnostic"))
map("n", "<leader>dl", vim.diagnostic.setloclist, desc("Diagnostic to location list"))

-- ============================================================================
-- LSP Keymaps (attached per buffer in lsp config)
-- ============================================================================
-- These are set in lua/plugins/lsp/init.lua on_attach
-- Documented here for reference:
-- K             - Hover documentation
-- gd            - Go to definition
-- gD            - Go to declaration
-- gi            - Go to implementation
-- gr            - Go to references
-- <leader>ca    - Code actions
-- <leader>rn    - Rename symbol
-- <leader>f     - Format document
-- [d / ]d       - Navigate diagnostics

-- ============================================================================
-- Plugin Keymaps
-- ============================================================================
-- Most plugin keymaps are defined in their respective plugin config files
-- This keeps keymaps close to the functionality they control

-- File Explorer (NvimTree)
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", desc("Toggle file explorer"))
map("n", "<leader>ef", "<cmd>NvimTreeFindFile<CR>", desc("Find file in explorer"))

-- Telescope (more in lua/plugins/telescope.lua)
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", desc("Find files"))
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", desc("Live grep"))
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", desc("Find buffers"))
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", desc("Help tags"))
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc("Recent files"))
map("n", "<leader>fc", "<cmd>Telescope grep_string<CR>", desc("Find string under cursor"))
map("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc("Search in current buffer"))

-- Trouble (diagnostics)
map("n", "<leader>xx", "<cmd>TroubleToggle<CR>", desc("Toggle Trouble"))
map("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", desc("Workspace diagnostics"))
map("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>", desc("Document diagnostics"))
map("n", "<leader>xq", "<cmd>TroubleToggle quickfix<CR>", desc("Quickfix"))
map("n", "<leader>xl", "<cmd>TroubleToggle loclist<CR>", desc("Location list"))

-- Git (more in lua/plugins/git.lua)
map("n", "<leader>gg", "<cmd>LazyGit<CR>", desc("LazyGit"))
map("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>", desc("Git blame line"))
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", desc("Preview hunk"))
map("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", desc("Reset hunk"))

-- Undotree
map("n", "<leader>u", "<cmd>UndotreeToggle<CR>", desc("Toggle undotree"))

-- ============================================================================
-- Disable arrow keys in normal mode (optional - encourages hjkl)
-- Uncomment if you want to force good habits
-- ============================================================================
-- map("n", "<Up>", "<Nop>", desc("Disabled"))
-- map("n", "<Down>", "<Nop>", desc("Disabled"))
-- map("n", "<Left>", "<Nop>", desc("Disabled"))
-- map("n", "<Right>", "<Nop>", desc("Disabled"))
