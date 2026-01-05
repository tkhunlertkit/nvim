-- ============================================================================
-- Core Autocommands
-- Automatic behaviors triggered by events
-- ============================================================================

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- ============================================================================
-- Highlight on Yank
-- Brief visual feedback when yanking text
-- ============================================================================
local highlight_group = augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = highlight_group,
  desc = "Highlight yanked text briefly",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 200,
    })
  end,
})

-- ============================================================================
-- Auto Format on Save
-- Format files with LSP formatter before saving
-- ============================================================================
local format_group = augroup("AutoFormat", { clear = true })
autocmd("BufWritePre", {
  group = format_group,
  desc = "Format buffer before saving",
  pattern = { "*.lua", "*.py", "*.js", "*.ts", "*.jsx", "*.tsx", "*.rs", "*.go" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- ============================================================================
-- Remove Trailing Whitespace
-- Clean up trailing whitespace on save
-- ============================================================================
local trim_group = augroup("TrimWhitespace", { clear = true })
autocmd("BufWritePre", {
  group = trim_group,
  desc = "Remove trailing whitespace on save",
  pattern = "*",
  callback = function()
    -- Save cursor position
    local save_cursor = vim.fn.getpos(".")
    -- Remove trailing whitespace
    vim.cmd([[%s/\s\+$//e]])
    -- Restore cursor position
    vim.fn.setpos(".", save_cursor)
  end,
})

-- ============================================================================
-- Restore Cursor Position
-- Jump to last known cursor position when opening a file
-- ============================================================================
local cursor_group = augroup("RestoreCursor", { clear = true })
autocmd("BufReadPost", {
  group = cursor_group,
  desc = "Restore cursor position",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- ============================================================================
-- Auto Create Directories
-- Automatically create parent directories when saving a file
-- ============================================================================
local mkdir_group = augroup("AutoMkdir", { clear = true })
autocmd("BufWritePre", {
  group = mkdir_group,
  desc = "Auto create parent directories",
  callback = function(event)
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- ============================================================================
-- Resize Splits on Window Resize
-- Automatically resize splits when terminal window is resized
-- ============================================================================
local resize_group = augroup("ResizeSplits", { clear = true })
autocmd("VimResized", {
  group = resize_group,
  desc = "Resize splits on window resize",
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- ============================================================================
-- Close Certain Filetypes with 'q'
-- Quick close for help, man pages, quickfix, etc.
-- ============================================================================
local close_group = augroup("CloseWithQ", { clear = true })
autocmd("FileType", {
  group = close_group,
  desc = "Close certain filetypes with q",
  pattern = {
    "qf",
    "help",
    "man",
    "lspinfo",
    "checkhealth",
    "startuptime",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", {
      buffer = event.buf,
      silent = true,
      desc = "Close window",
    })
  end,
})

-- ============================================================================
-- Check if File Changed Outside Vim
-- Prompt to reload if file was modified externally
-- ============================================================================
local checktime_group = augroup("CheckTime", { clear = true })
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = checktime_group,
  desc = "Check if buffer changed outside vim",
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- ============================================================================
-- Disable Auto Comment on New Line
-- Prevents automatic comment continuation
-- ============================================================================
local no_auto_comment = augroup("NoAutoComment", { clear = true })
autocmd("BufEnter", {
  group = no_auto_comment,
  desc = "Disable auto comment on new line",
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- ============================================================================
-- Terminal Settings
-- Improve terminal buffer behavior
-- ============================================================================
local terminal_group = augroup("TerminalSettings", { clear = true })
autocmd("TermOpen", {
  group = terminal_group,
  desc = "Terminal settings",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.scrolloff = 0
  end,
})

-- ============================================================================
-- File Type Specific Settings
-- Custom settings per file type
-- ============================================================================

-- Markdown
local markdown_group = augroup("MarkdownSettings", { clear = true })
autocmd("FileType", {
  group = markdown_group,
  pattern = "markdown",
  desc = "Markdown specific settings",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.conceallevel = 2
  end,
})

-- Git commit messages
local gitcommit_group = augroup("GitCommitSettings", { clear = true })
autocmd("FileType", {
  group = gitcommit_group,
  pattern = "gitcommit",
  desc = "Git commit specific settings",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.colorcolumn = "72"
  end,
})

-- JSON - 2 space indentation
local json_group = augroup("JsonSettings", { clear = true })
autocmd("FileType", {
  group = json_group,
  pattern = { "json", "jsonc" },
  desc = "JSON specific settings",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})

-- Python - 4 space indentation (PEP 8)
local python_group = augroup("PythonSettings", { clear = true })
autocmd("FileType", {
  group = python_group,
  pattern = "python",
  desc = "Python specific settings",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})

-- Go - tabs instead of spaces
local go_group = augroup("GoSettings", { clear = true })
autocmd("FileType", {
  group = go_group,
  pattern = "go",
  desc = "Go specific settings",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

-- YAML - 2 space indentation
local yaml_group = augroup("YamlSettings", { clear = true })
autocmd("FileType", {
  group = yaml_group,
  pattern = { "yaml", "yml" },
  desc = "YAML specific settings",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})

-- ============================================================================
-- Big File Handling
-- Disable heavy features for large files to improve performance
-- ============================================================================
local bigfile_group = augroup("BigFile", { clear = true })
autocmd("BufReadPre", {
  group = bigfile_group,
  desc = "Disable features for large files",
  callback = function(event)
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(event.buf))
    if ok and stats and stats.size > 1024000 then -- 1MB
      vim.b.large_buf = true
      vim.opt_local.eventignore:append({
        "FileType",
        "Syntax",
      })
      vim.opt_local.undolevels = -1
      vim.opt_local.swapfile = false
      vim.opt_local.loadplugins = false
      vim.schedule(function()
        vim.bo[event.buf].syntax = vim.filetype.match({ buf = event.buf }) or ""
      end)
    end
  end,
})
