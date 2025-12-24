local M = {}

function M.setup(capabilities)
	-- helper function to get the current environment python path
	local function get_conda_python()
		if vim.env.CONDA_PREFIX and vim.env.CONDA_PREFIX ~= "" then
			local candidate = vim.env.CONDA_PREFIX .. "/bin/python"
			if vim.fn.executable(candidate) == 1 then
				return candidate
			end
		end
		-- Fallbacks if no conda env is active
		if vim.fn.exepath("python3") ~= "" then
			return vim.fn.exepath("python3")
		elseif vim.fn.exepath("python") ~= "" then
			return vim.fn.exepath("python")
		else
			return "python"
		end
	end

	-- Pyright LSP using modern API
	vim.lsp.config("pyright", {
		capabilities = capabilities,
		settings = {
			python = {
				pythonPath = get_conda_python(),
			},
		},
		on_init = function(client)
			-- for debugging purposes
			local env_name = vim.env.CONDA_DEFAULT_ENV

			-- Or derive name from CONDA_PREFIX path
			if not env_name and vim.env.CONDA_PREFIX then
				env_name = vim.fn.fnamemodify(vim.env.CONDA_PREFIX, ":t")
			end
			print("python env:", env_name or "unknown")
		end,
	})
	vim.lsp.enable("pyright")
end

return M
