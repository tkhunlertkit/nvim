-- lua/config/mason.lua
-- Modern Mason configuration using vim namespace
-- Mason is the package manager for language servers, formatters, linters
-- Reference: https://github.com/williamboman/mason.nvim

local M = {}

-- Load mason module
local status_ok, mason = pcall(require, "mason")
if not status_ok then
  vim.notify("Mason is not installed. Install it with your package manager.", vim.log.levels.ERROR)
  return M
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
  vim.notify("mason-lspconfig is not installed.", vim.log.levels.ERROR)
  return M
end

-- Mason configuration
-- This defines how Mason behaves and where it stores packages
local mason_config = {
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
    border = "rounded",
    width = 0.8,
    height = 0.9,
  },
  pip = {
    upgrade_pip = false,  -- Set to true if you want auto pip updates
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

-- Setup Mason with configuration
mason.setup(mason_config)

-- Configure mason-lspconfig integration
-- This automatically ensures language servers are installed when configured
local mason_lspconfig_config = {
  automatic_installation = true,  -- Auto-install configured servers
  ensure_installed = {
    "pyright",      -- Python
    "ts_ls",        -- TypeScript/JavaScript (note: ts_ls replaces tsserver)
    "lua_ls",       -- Lua
    "efm",          -- General formatter
  },
}

mason_lspconfig.setup(mason_lspconfig_config)

-- Hook: automatically setup language servers when installed
-- This integrates mason with lspconfig
mason_lspconfig.setup_handlers({
  -- Default handler for any server
  function(server_name)
    local lspconfig = require("lspconfig")
    lspconfig[server_name].setup({})
  end,
  
  -- Custom handler for specific servers can go here
  -- Example:
  -- ["pyright"] = function()
  --   require("lspconfig").pyright.setup({
  --     settings = { python = { analysis = { typeCheckingMode = "off" } } }
  --   })
  -- end,
})

return M
