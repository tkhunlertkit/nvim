-- init.lua
-- Neovim 0.11.5+ Configuration
-- Main entry point for configuration

vim.env.NVIM_SUPPRESS_LSPCONFIG_DEPRECATION = "1"

-- Core settings and keybindings
require("core")

-- Plugin management and configurations
require("plugins")
