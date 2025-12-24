local M = {}

function M.setup(capabilities)
	-- Gopls config
	vim.lsp.config("gopls", {
		cmd = { "gopls" },
		filetypes = { "go", "gomod", "gowork", "gotmpl" },
		root_dir = function(fname)
			-- Ensure fname is a proper string path
			if type(fname) ~= "string" or fname == "" then
				fname = vim.api.nvim_buf_get_name(0)
			end

			-- Try to find a Go module/workspace or git root
			local found = vim.fs.find({ "go.work", "go.mod", ".git" }, {
				upward = true,
				path = fname,
				stop = vim.loop.os_homedir(),
			})[1]

			if not found then
				-- Fallback: directory of the file, or current working dir
				local dir = vim.fs.dirname(fname)
				if dir and dir ~= "" then
					return dir
				end
				return vim.loop.cwd()
			end

			return vim.fs.dirname(found)
		end,
		capabilities = capabilities,
		settings = {
			gopls = {
				analyses = {
					unusedparams = true,
				},
				staticcheck = true,
				gofumpt = true,
			},
		},
	})

	vim.lsp.enable("gopls")
end

return M
