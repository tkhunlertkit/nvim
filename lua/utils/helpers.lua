-- lua/utils/helpers.lua
-- Helper functions for LSP and general configuration
-- These are optional utilities that make common tasks easier

local M = {}

-- ============================================================================
-- LSP Utilities
-- ============================================================================

--- Check if a language server is active in the current buffer
---@return boolean
function M.lsp_active()
  return #vim.lsp.get_active_clients() > 0
end

--- Get all active language servers
---@return table
function M.get_active_servers()
  local clients = vim.lsp.get_active_clients()
  local servers = {}
  for _, client in ipairs(clients) do
    table.insert(servers, client.name)
  end
  return servers
end

--- Get the client for a specific server name
---@param server_name string
---@return table|nil
function M.get_client(server_name)
  local clients = vim.lsp.get_active_clients()
  for _, client in ipairs(clients) do
    if client.name == server_name then
      return client
    end
  end
  return nil
end

--- Restart all language servers
function M.restart_lsp()
  vim.cmd("LspStop")
  vim.defer_fn(function()
    vim.cmd("LspStart")
  end, 500)
end

--- Create a custom command for LSP operations
---@param name string Command name
---@param callback function Callback to execute
function M.create_command(name, callback)
  vim.api.nvim_create_user_command(name, callback, {})
end

-- ============================================================================
-- Notification Utilities
-- ============================================================================

--- Show info notification
---@param message string
function M.notify_info(message)
  vim.notify(message, vim.log.levels.INFO)
end

--- Show warning notification
---@param message string
function M.notify_warn(message)
  vim.notify(message, vim.log.levels.WARN)
end

--- Show error notification
---@param message string
function M.notify_error(message)
  vim.notify(message, vim.log.levels.ERROR)
end

--- Show debug notification
---@param message string
function M.notify_debug(message)
  vim.notify(message, vim.log.levels.DEBUG)
end

-- ============================================================================
-- Diagnostic Utilities
-- ============================================================================

--- Show diagnostics for all buffers in a floating window
function M.show_all_diagnostics()
  local diagnostics = vim.diagnostic.get()
  if #diagnostics == 0 then
    M.notify_info("No diagnostics found")
    return
  end
  vim.diagnostic.setqflist()
  vim.cmd("copen")
end

--- Count diagnostics by severity
---@return table {errors, warnings, hints, infos}
function M.count_diagnostics()
  local diagnostics = vim.diagnostic.get()
  local counts = { errors = 0, warnings = 0, hints = 0, infos = 0 }
  
  for _, diagnostic in ipairs(diagnostics) do
    if diagnostic.severity == vim.diagnostic.severity.ERROR then
      counts.errors = counts.errors + 1
    elseif diagnostic.severity == vim.diagnostic.severity.WARN then
      counts.warnings = counts.warnings + 1
    elseif diagnostic.severity == vim.diagnostic.severity.HINT then
      counts.hints = counts.hints + 1
    elseif diagnostic.severity == vim.diagnostic.severity.INFO then
      counts.infos = counts.infos + 1
    end
  end
  
  return counts
end

-- ============================================================================
-- Buffer Utilities
-- ============================================================================

--- Get current line number
---@return number
function M.get_line()
  return vim.api.nvim_win_get_cursor(0)[1]
end

--- Get current column number
---@return number
function M.get_col()
  return vim.api.nvim_win_get_cursor(0)[2]
end

--- Get current buffer number
---@return number
function M.get_bufnr()
  return vim.api.nvim_get_current_buf()
end

--- Get current file path
---@return string
function M.get_file_path()
  return vim.api.nvim_buf_get_name(0)
end

-- ============================================================================
-- Testing & Debug Utilities
-- ============================================================================

--- Print table contents for debugging
---@param tbl table
function M.dump(tbl)
  vim.notify(vim.inspect(tbl), vim.log.levels.DEBUG)
end

--- Print LSP client information
function M.debug_lsp()
  local clients = vim.lsp.get_active_clients()
  local output = "Active LSP Clients:\n"
  for _, client in ipairs(clients) do
    output = output .. string.format("  • %s (ID: %d)\n", client.name, client.id)
  end
  M.notify_debug(output)
end

--- Check LSP health
function M.check_lsp_health()
  local clients = vim.lsp.get_active_clients()
  if #clients == 0 then
    M.notify_warn("No LSP clients active. Try :LspInfo")
    return
  end
  
  local status = "LSP Status: " .. #clients .. " client(s) active\n"
  for _, client in ipairs(clients) do
    status = status .. "  ✓ " .. client.name .. "\n"
  end
  M.notify_info(status)
end

return M
