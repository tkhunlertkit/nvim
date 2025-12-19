-- lua/core/autocmds.lua
-- Autocommands for Neovim

local api = vim.api

-- Create augroup for custom autocommands
local group = api.nvim_create_augroup("UserAutoCmds", { clear = true })

-- ============================================================================
-- Highlight on yank
-- ============================================================================

api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- ============================================================================
-- Auto-format on save (optional - configure with your LSP)
-- ============================================================================

-- Uncomment if you want auto-format on save
-- api.nvim_create_autocmd("BufWritePre", {
--   group = group,
--   callback = function()
--     vim.lsp.buf.format({ async = false })
--   end,
-- })

-- ============================================================================
-- Restore cursor position
-- ============================================================================

api.nvim_create_autocmd("BufReadPost", {
  group = group,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- ============================================================================
-- Close certain filetypes with 'q'
-- ============================================================================

api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "qf", "help", "lspinfo", "man", "query" },
  callback = function()
    vim.keymap.set("n", "q", ":close<CR>", { noremap = true, silent = true, buffer = true })
  end,
})

-- ============================================================================
-- Disable line numbers in terminal mode
-- ============================================================================

api.nvim_create_autocmd("TermOpen", {
  group = group,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})