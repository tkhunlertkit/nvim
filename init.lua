-- Main Neovim configuration entry point
-- This file acts as the central hub for all configurations
-- Load all modules in the correct order

-- Ensure lua directory is in runtime path
vim.opt.runtimepath:append(vim.fn.stdpath("config") .. "/lua")

-- Initialize configuration system
require("config.init")
