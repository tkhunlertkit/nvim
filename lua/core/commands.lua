-- ============================================================================
-- Core User Commands
-- Custom commands for enhanced functionality
-- ============================================================================

local cmd = vim.api.nvim_create_user_command

-- ============================================================================
-- Config Management
-- ============================================================================

-- Reload entire Neovim configuration
cmd("ReloadConfig", function()
  -- Clear all loaded modules that are part of our config
  for name, _ in pairs(package.loaded) do
    if name:match("^core") or name:match("^plugins") or name:match("^utils") then
      package.loaded[name] = nil
    end
  end

  -- Reload init.lua
  dofile(vim.env.MYVIMRC)

  -- Notify user
  vim.notify("Config reloaded!", vim.log.levels.INFO, {
    title = "Neovim",
  })
end, {
  desc = "Reload Neovim configuration",
})

-- Open config directory
cmd("ConfigDir", function()
  vim.cmd("edit " .. vim.fn.stdpath("config"))
end, {
  desc = "Open config directory",
})

-- Edit init.lua
cmd("ConfigEdit", function()
  vim.cmd("edit " .. vim.env.MYVIMRC)
end, {
  desc = "Edit init.lua",
})

-- ============================================================================
-- Plugin Management
-- ============================================================================

-- Lazy.nvim wrapper commands
cmd("PluginInstall", function()
  require("lazy").install()
end, {
  desc = "Install plugins with Lazy.nvim",
})

cmd("PluginUpdate", function()
  require("lazy").update()
end, {
  desc = "Update plugins with Lazy.nvim",
})

cmd("PluginSync", function()
  require("lazy").sync()
end, {
  desc = "Sync plugins with Lazy.nvim",
})

cmd("PluginClean", function()
  require("lazy").clean()
end, {
  desc = "Clean unused plugins with Lazy.nvim",
})

cmd("PluginProfile", function()
  require("lazy").profile()
end, {
  desc = "Show plugin loading times",
})

-- ============================================================================
-- Buffer Management
-- ============================================================================

-- Delete all buffers except current
cmd("BufOnly", function()
  vim.cmd("%bd|e#|bd#")
end, {
  desc = "Delete all buffers except current",
})

-- Delete all buffers
cmd("BufDeleteAll", function()
  vim.cmd("bufdo bd")
end, {
  desc = "Delete all buffers",
})

-- Close all hidden buffers
cmd("BufDeleteHidden", function()
  local visible_bufs = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    visible_bufs[vim.api.nvim_win_get_buf(win)] = true
  end

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and not visible_bufs[buf] then
      vim.api.nvim_buf_delete(buf, { force = false })
    end
  end

  vim.notify("Deleted all hidden buffers", vim.log.levels.INFO)
end, {
  desc = "Delete all hidden buffers",
})

-- ============================================================================
-- File Operations
-- ============================================================================

-- Copy current file path to clipboard
cmd("CopyPath", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Copied path: " .. path, vim.log.levels.INFO)
end, {
  desc = "Copy current file path to clipboard",
})

-- Copy current file name to clipboard
cmd("CopyFileName", function()
  local name = vim.fn.expand("%:t")
  vim.fn.setreg("+", name)
  vim.notify("Copied filename: " .. name, vim.log.levels.INFO)
end, {
  desc = "Copy current file name to clipboard",
})

-- Copy current directory to clipboard
cmd("CopyDir", function()
  local dir = vim.fn.expand("%:p:h")
  vim.fn.setreg("+", dir)
  vim.notify("Copied directory: " .. dir, vim.log.levels.INFO)
end, {
  desc = "Copy current directory to clipboard",
})

-- Delete current file and buffer
cmd("DeleteFile", function()
  local file = vim.fn.expand("%:p")
  if file == "" then
    vim.notify("No file to delete", vim.log.levels.WARN)
    return
  end

  local choice = vim.fn.confirm("Delete file: " .. file .. "?", "&Yes\n&No", 2)
  if choice == 1 then
    vim.cmd("bdelete!")
    vim.fn.delete(file)
    vim.notify("Deleted: " .. file, vim.log.levels.INFO)
  end
end, {
  desc = "Delete current file and buffer",
})

-- Rename current file
cmd("RenameFile", function()
  local old_name = vim.fn.expand("%:p")
  if old_name == "" then
    vim.notify("No file to rename", vim.log.levels.WARN)
    return
  end

  local new_name = vim.fn.input("New name: ", old_name, "file")
  if new_name == "" or new_name == old_name then
    return
  end

  vim.cmd("saveas " .. new_name)
  vim.fn.delete(old_name)
  vim.cmd("bdelete! " .. old_name)
  vim.notify("Renamed to: " .. new_name, vim.log.levels.INFO)
end, {
  desc = "Rename current file",
})

-- ============================================================================
-- Formatting & Cleaning
-- ============================================================================

-- Format entire buffer
cmd("Format", function()
  vim.lsp.buf.format({ async = false })
end, {
  desc = "Format current buffer with LSP",
})

-- Remove trailing whitespace manually
cmd("TrimWhitespace", function()
  local save_cursor = vim.fn.getpos(".")
  vim.cmd([[%s/\s\+$//e]])
  vim.fn.setpos(".", save_cursor)
  vim.notify("Removed trailing whitespace", vim.log.levels.INFO)
end, {
  desc = "Remove trailing whitespace",
})

-- Convert tabs to spaces
cmd("TabsToSpaces", function()
  local save_cursor = vim.fn.getpos(".")
  vim.cmd([[%s/\t/  /g]])
  vim.fn.setpos(".", save_cursor)
  vim.notify("Converted tabs to spaces", vim.log.levels.INFO)
end, {
  desc = "Convert tabs to spaces",
})

-- Convert spaces to tabs
cmd("SpacesToTabs", function()
  local save_cursor = vim.fn.getpos(".")
  vim.cmd([[%s/  /\t/g]])
  vim.fn.setpos(".", save_cursor)
  vim.notify("Converted spaces to tabs", vim.log.levels.INFO)
end, {
  desc = "Convert spaces to tabs",
})

-- ============================================================================
-- Diagnostics & LSP
-- ============================================================================

-- Toggle diagnostics
local diagnostics_active = true
cmd("DiagnosticsToggle", function()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.enable()
    vim.notify("Diagnostics enabled", vim.log.levels.INFO)
  else
    vim.diagnostic.disable()
    vim.notify("Diagnostics disabled", vim.log.levels.INFO)
  end
end, {
  desc = "Toggle diagnostics",
})

-- Show LSP info
cmd("LspInfo", function()
  vim.cmd("LspInfo")
end, {
  desc = "Show LSP information",
})

-- Restart LSP
cmd("LspRestart", function()
  vim.cmd("LspRestart")
  vim.notify("LSP restarted", vim.log.levels.INFO)
end, {
  desc = "Restart LSP server",
})

-- ============================================================================
-- Utilities
-- ============================================================================

-- Toggle line numbers
cmd("NumbersToggle", function()
  vim.opt.number = not vim.opt.number:get()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, {
  desc = "Toggle line numbers",
})

-- Toggle wrap
cmd("WrapToggle", function()
  vim.opt.wrap = not vim.opt.wrap:get()
end, {
  desc = "Toggle line wrapping",
})

-- Toggle spell check
cmd("SpellToggle", function()
  vim.opt.spell = not vim.opt.spell:get()
end, {
  desc = "Toggle spell checking",
})

-- Toggle colorcolumn
cmd("ColorColumnToggle", function()
  if vim.opt.colorcolumn:get()[1] == "" then
    vim.opt.colorcolumn = "80"
  else
    vim.opt.colorcolumn = ""
  end
end, {
  desc = "Toggle colorcolumn",
})

-- Change colorcolumn value
cmd("ColorColumn", function(opts)
  local col = tonumber(opts.args)
  if col and col > 0 then
    vim.opt.colorcolumn = tostring(col)
    vim.notify("Set colorcolumn to " .. col, vim.log.levels.INFO)
  else
    vim.notify("Invalid column number", vim.log.levels.ERROR)
  end
end, {
  nargs = 1,
  desc = "Set colorcolumn to specified value",
})

-- Measure startup time
cmd("StartupTime", function()
  vim.cmd("StartupTime")
end, {
  desc = "Measure Neovim startup time",
})

-- ============================================================================
-- Session Management
-- ============================================================================

-- Save session
cmd("SessionSave", function(opts)
  local session_name = opts.args ~= "" and opts.args or "Session.vim"
  vim.cmd("mksession! " .. session_name)
  vim.notify("Session saved: " .. session_name, vim.log.levels.INFO)
end, {
  nargs = "?",
  complete = "file",
  desc = "Save current session",
})

-- Load session
cmd("SessionLoad", function(opts)
  local session_name = opts.args ~= "" and opts.args or "Session.vim"
  if vim.fn.filereadable(session_name) == 1 then
    vim.cmd("source " .. session_name)
    vim.notify("Session loaded: " .. session_name, vim.log.levels.INFO)
  else
    vim.notify("Session not found: " .. session_name, vim.log.levels.ERROR)
  end
end, {
  nargs = "?",
  complete = "file",
  desc = "Load session",
})

-- ============================================================================
-- Quick Fixes
-- ============================================================================

-- Fix common typos
vim.cmd([[
  command! W w
  command! Q q
  command! Wq wq
  command! WQ wq
  command! Qa qa
  command! QA qa
]])
