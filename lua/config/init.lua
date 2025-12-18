-- lua/config/init.lua
-- Central configuration loader
-- Loads all configuration modules in proper order with error handling

local M = {}

-- Helper function for safe module loading
local function safe_require(module_name)
  local status_ok, module = pcall(require, module_name)
  if not status_ok then
    vim.notify("Failed to load module: " .. module_name .. "\n" .. module, vim.log.levels.ERROR)
    return nil
  end
  return module
end

-- Loading sequence is critical for LSP to work properly
-- 1. Load diagnostics first (no dependencies)
-- 2. Load mason (package manager)
-- 3. Load lspconfig (LSP configurations)
-- 4. Load keymaps last (depends on LSP being initialized)

vim.notify("🔧 Initializing Neovim configuration...", vim.log.levels.INFO)

-- 1. Setup diagnostic display options
safe_require("config.diagnostics")
vim.notify("✓ Diagnostics configured", vim.log.levels.DEBUG)

-- 2. Setup Mason (package/language server installer)
safe_require("config.mason")
vim.notify("✓ Mason configured", vim.log.levels.DEBUG)

-- 3. Setup LSP configurations
safe_require("config.lspconfig")
vim.notify("✓ LSP configured", vim.log.levels.DEBUG)

-- 4. Setup keymaps (depends on LSP autocmds being registered)
safe_require("config.keymaps")
vim.notify("✓ Keymaps configured", vim.log.levels.DEBUG)

-- 5. Load utilities (optional, for helper functions)
safe_require("utils.helpers")
vim.notify("✓ Utilities loaded", vim.log.levels.DEBUG)

vim.notify("✅ Configuration loaded successfully!", vim.log.levels.INFO)

return M
