-- ============================================================================
-- Neovim Init File
-- Bootstrap lazy.nvim and load configuration modules
-- ============================================================================

-- Set leader keys before loading anything else
-- This ensures plugins can use the leader key in their configurations
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load core configuration modules
-- Order matters: options first, then plugins, then keymaps/autocmds
require("core.options")      -- Global vim options
require("core.keymaps")       -- Key mappings
require("core.autocmds")      -- Autocommands
require("core.commands")      -- User commands

-- Setup lazy.nvim and load all plugins
require("plugins")

-- Load custom user configuration if it exists
-- This allows for machine-specific settings without modifying main config
pcall(require, "config.local")
