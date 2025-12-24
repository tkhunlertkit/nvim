-- lua/utils/init.lua
-- Utility functions for Neovim configuration

local M = {}

-- ============================================================================
-- Keymap Helpers
-- ============================================================================

--- Set a global keymap with consistent options
---@param mode string | table: vim mode(s) (e.g., "n", "v", {"n", "v"})
---@param lhs string: left-hand side (key combination)
---@param rhs string | function: right-hand side (command or Lua function)
---@param opts table: additional options (e.g., { noremap = true, silent = true })
function M.map(mode, lhs, rhs, opts)
	local default_opts = { noremap = true, silent = true }
	opts = vim.tbl_extend("force", default_opts, opts or {})
	vim.keymap.set(mode, lhs, rhs, opts)
end

--- Map a keymap to a Lua function
---@param mode string | table: vim mode(s)
---@param lhs string: key combination
---@param fn function: Lua function to execute
---@param opts table: additional options
function M.map_fn(mode, lhs, fn, opts)
	M.map(mode, lhs, fn, vim.tbl_extend("force", { noremap = true, silent = true }, opts or {}))
end

-- ============================================================================
-- Command Helpers
-- ============================================================================

--- Create a user command
---@param name string: command name
---@param fn function | string: Lua function or command string
---@param opts table: additional options
function M.command(name, fn, opts)
	vim.api.nvim_create_user_command(name, fn, opts or {})
end

-- ============================================================================
-- Autocommand Helpers
-- ============================================================================

--- Create an autocommand group
---@param name string: group name
function M.augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

--- Create an autocommand
---@param event string | table: event(s)
---@param opts table: options including callback, command, pattern, etc.
function M.autocmd(event, opts)
	return vim.api.nvim_create_autocmd(event, opts)
end

-- ============================================================================
-- Buffer Helpers
-- ============================================================================

--- Get current buffer content as a table of lines
function M.get_buffer_lines()
	return vim.api.nvim_buf_get_lines(0, 0, -1, false)
end

--- Set buffer content from a table of lines
---@param lines table: table of strings
function M.set_buffer_lines(lines)
	vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

--- Get current buffer name
function M.get_buffer_name()
	return vim.api.nvim_buf_get_name(0)
end

--- Get current buffer filetype
function M.get_buffer_filetype()
	return vim.bo.filetype
end

-- ============================================================================
-- Window Helpers
-- ============================================================================

--- Get current window height
function M.get_window_height()
	return vim.api.nvim_win_get_height(0)
end

--- Get current window width
function M.get_window_width()
	return vim.api.nvim_win_get_width(0)
end

--- Create a floating window with default options
---@param opts table: window options
function M.create_float(opts)
	local width = opts.width or 80
	local height = opts.height or 24
	local buf = vim.api.nvim_create_buf(false, true)

	local win_opts = {
		relative = "cursor",
		width = width,
		height = height,
		row = 1,
		col = 0,
		style = "minimal",
		border = "rounded",
	}

	win_opts = vim.tbl_extend("force", win_opts, opts or {})

	local win = vim.api.nvim_open_win(buf, true, win_opts)
	return { buf = buf, win = win }
end

-- ============================================================================
-- Notification Helpers
-- ============================================================================

--- Show an info notification
---@param msg string: message to show
function M.info(msg)
	vim.notify(msg, vim.log.levels.INFO)
end

--- Show a warning notification
---@param msg string: message to show
function M.warn(msg)
	vim.notify(msg, vim.log.levels.WARN)
end

--- Show an error notification
---@param msg string: message to show
function M.error(msg)
	vim.notify(msg, vim.log.levels.ERROR)
end

-- ============================================================================
-- File Helpers
-- ============================================================================

--- Check if a file exists
---@param path string: file path
function M.file_exists(path)
	return vim.fn.filereadable(path) == 1
end

--- Check if a directory exists
---@param path string: directory path
function M.dir_exists(path)
	return vim.fn.isdirectory(path) == 1
end

--- Get the home directory path
function M.get_home()
	return vim.fn.expand("~")
end

--- Get the config directory path
function M.get_config_dir()
	return vim.fn.stdpath("config")
end

--- Get the data directory path
function M.get_data_dir()
	return vim.fn.stdpath("data")
end

-- ============================================================================
-- Plugin Helpers
-- ============================================================================

--- Check if a plugin is installed
---@param plugin_name string: plugin name (e.g., "telescope.nvim")
function M.has_plugin(plugin_name)
	return require("lazy.core.config").plugins[plugin_name] ~= nil
end

-- ============================================================================
-- LSP Helpers
-- ============================================================================

--- Get the active LSP clients for the current buffer
function M.get_lsp_clients()
	return vim.lsp.get_clients({ bufnr = 0 })
end

--- Check if a specific LSP is running
---@param server_name string: LSP server name
function M.has_lsp(server_name)
	local clients = M.get_lsp_clients()
	for _, client in ipairs(clients) do
		if client.name == server_name then
			return true
		end
	end
	return false
end

return M

