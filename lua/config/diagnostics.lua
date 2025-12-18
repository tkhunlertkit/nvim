-- lua/config/diagnostics.lua
-- Modern diagnostic configuration using vim.diagnostic APIs
-- Handles display, signs, and virtual text for diagnostics

local M = {}

-- Configure diagnostic display settings
-- These affect how errors, warnings, and hints appear
vim.diagnostic.config({
  virtual_text = true,           -- Show diagnostics as virtual text at end of line
  signs = true,                  -- Show signs in the gutter
  underline = true,              -- Underline problematic code
  update_in_insert = false,       -- Don't update diagnostics while typing in insert mode
  severity_sort = true,           -- Sort diagnostics by severity
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",            -- Show what language server reported the issue
    header = "",
    prefix = "",
  },
})

-- Define diagnostic signs and their appearance
local signs = {
  Error = "❌",
  Warn = "⚠️ ",
  Hint = "💡",
  Info = "ℹ️ ",
}

-- Apply custom signs for each diagnostic level
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Optional: Set diagnostic text format
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",  -- Bullet point icon
    spacing = 4,
  },
})

return M
