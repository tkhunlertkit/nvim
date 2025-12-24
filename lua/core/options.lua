-- lua/core/options.lua
-- Neovim global options and settings

local opt = vim.opt
local g = vim.g

-- Leader key
g.mapleader = " "
g.maplocalleader = " "

-- Disable Space as a motion in NORMAL mode
vim.keymap.set("n", "<Space>", "<Nop>", { noremap = true, silent = true })

-- General settings
opt.number = true -- Show line numbers
opt.relativenumber = true -- Relative line numbers
opt.mouse = "" -- Enable mouse support
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.undofile = true -- Persistent undo
opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- Indentation
opt.tabstop = 4 -- Tab width
opt.shiftwidth = 4 -- Shift width
opt.expandtab = true -- Convert tabs to spaces
opt.autoindent = true -- Auto-indent
opt.smartindent = true -- Smart indentation

-- Search and replace
opt.ignorecase = true -- Case-insensitive search
opt.smartcase = true -- Case-sensitive when uppercase is used
opt.hlsearch = true -- Highlight search results
opt.incsearch = true -- Incremental search

-- Display
opt.termguicolors = true -- True color support
opt.wrap = true -- Wrap long lines
opt.breakindent = true -- Preserve indentation on wrapped lines
opt.showbreak = "  → " -- Show break indicator
opt.scrolloff = 8 -- Scroll padding
opt.sidescrolloff = 8 -- Horizontal scroll padding
opt.splitbelow = true -- Horizontal split position
opt.splitright = true -- Vertical split position

-- Performance
opt.timeoutlen = 300 -- Timeout for keymaps
opt.updatetime = 250 -- Faster completion and diagnostics
opt.lazyredraw = true -- Lazy redraw during macros

-- Behavior
opt.hidden = true -- Allow unsaved buffers
opt.cursorline = true -- Highlight current line
opt.cursorcolumn = false -- Don't highlight column
opt.list = true -- Show whitespace characters
opt.listchars = {
	tab = "→ ",
	trail = "·",
	nbsp = "·",
	extends = "»",
	precedes = "«",
}

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }
opt.pumheight = 10 -- Completion menu height

-- Backup and swap
opt.backup = false -- Don't create backup files
opt.swapfile = false -- Don't create swap files
opt.writebackup = false -- Don't backup when overwriting

-- Statusline - ensure it's always visible at bottom
opt.laststatus = 2 -- Always show statusline (2 = always visible)

-- Save buffers, window sizes, tabpages, etc. in sessions
opt.sessionoptions = {
	"buffers",
	"curdir",
	"tabpages",
	"winsize",
	"winpos",
	"terminal",
}
opt.showtabline = 0
