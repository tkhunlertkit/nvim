-- ============================================================================
-- Core Options
-- Global Neovim settings for appearance, behavior, and performance
-- ============================================================================

local opt = vim.opt
local g = vim.g

-- ============================================================================
-- UI & Appearance
-- ============================================================================
opt.number = true           -- Show line numbers
opt.relativenumber = true   -- Show relative line numbers
opt.cursorline = true       -- Highlight current line
opt.signcolumn = "yes"      -- Always show sign column to prevent shift
opt.colorcolumn = "120"      -- Highlight column 80
opt.scrolloff = 8           -- Keep 8 lines above/below cursor
opt.sidescrolloff = 8       -- Keep 8 columns left/right of cursor
opt.wrap = false            -- Disable line wrapping
opt.termguicolors = true    -- Enable 24-bit RGB colors
opt.showmode = false        -- Don't show mode (status line will show it)
opt.pumheight = 10          -- Popup menu height
opt.pumblend = 10           -- Popup menu transparency

-- ============================================================================
-- Indentation & Formatting
-- ============================================================================
opt.tabstop = 2             -- Number of spaces a tab counts for
opt.shiftwidth = 2          -- Number of spaces for auto-indent
opt.softtabstop = 2         -- Number of spaces for <Tab> in insert mode
opt.expandtab = true        -- Use spaces instead of tabs
opt.smartindent = true      -- Smart auto-indenting
opt.autoindent = true       -- Copy indent from current line

-- ============================================================================
-- Search & Completion
-- ============================================================================
opt.ignorecase = true       -- Ignore case in search
opt.smartcase = true        -- Override ignorecase if search has uppercase
opt.hlsearch = true         -- Highlight search results
opt.incsearch = true        -- Show matches as you type
opt.completeopt = { "menu", "menuone", "noselect" }  -- Completion options

-- ============================================================================
-- File Handling
-- ============================================================================
opt.hidden = true           -- Allow hidden buffers
opt.backup = false          -- Don't create backup files
opt.writebackup = false     -- Don't create backup before overwriting
opt.swapfile = false        -- Don't create swap files
opt.undofile = true         -- Enable persistent undo
opt.undodir = vim.fn.stdpath("data") .. "/undo"  -- Undo file location
opt.autoread = true         -- Auto-reload files changed outside vim
opt.fileencoding = "utf-8"  -- File encoding

-- ============================================================================
-- Splits & Windows
-- ============================================================================
opt.splitright = true       -- Open vertical splits to the right
opt.splitbelow = true       -- Open horizontal splits below

-- ============================================================================
-- Performance
-- ============================================================================
opt.updatetime = 300        -- Faster completion (default: 4000ms)
opt.timeoutlen = 400        -- Time to wait for mapped sequence (default: 1000ms)
opt.lazyredraw = false      -- Don't redraw during macros (can cause issues with some plugins)

-- ============================================================================
-- Mouse & Clipboard
-- ============================================================================
opt.mouse = ""             -- Enable mouse in all modes
opt.clipboard = "unnamedplus"  -- Use system clipboard

-- ============================================================================
-- Command Line
-- ============================================================================
opt.cmdheight = 1           -- Command line height
opt.showcmd = true          -- Show partial commands

-- ============================================================================
-- Whitespace Characters
-- ============================================================================
opt.list = true             -- Show invisible characters
opt.listchars = {
  tab = "→ ",
  trail = "·",
  extends = "»",
  precedes = "«",
  nbsp = "␣",
}

-- ============================================================================
-- Folding (using Treesitter)
-- ============================================================================
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false      -- Don't fold by default
opt.foldlevel = 99          -- High fold level

-- ============================================================================
-- Spell Checking
-- ============================================================================
opt.spelllang = "en_us"
opt.spell = false           -- Disabled by default, enable per filetype

-- ============================================================================
-- Globals
-- ============================================================================
g.loaded_netrw = 1          -- Disable netrw (using nvim-tree instead)
g.loaded_netrwPlugin = 1

-- ============================================================================
-- Create undo directory if it doesn't exist
-- ============================================================================
local undo_dir = vim.fn.stdpath("data") .. "/undo"
if vim.fn.isdirectory(undo_dir) == 0 then
  vim.fn.mkdir(undo_dir, "p")
end
