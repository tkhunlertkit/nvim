-- lua/plugins/lualine.lua
--
--

local function macro_recording()
	local reg = vim.fn.reg_recording()
	if reg == "" then
		return ""
	end
	return "REC @" .. reg
end

-- selene: allow(mixed_table)
return {
	"nvim-lualine/lualine.nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "nord",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {},
				always_divide_middle = true,
				globalstatus = false,
				always_show_tabline = true,
			},
			sections = {
				lualine_a = { "mode", macro_recording },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { { "filename", file_status = true, path = 1 } },
				lualine_x = { "searchcount", "encoding", "fileformat", "filetype", "lsp_status" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = { "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {
				lualine_a = { "tabs" },
				lualine_b = {},
				lualine_c = {
					{
						function()
							-- Treesitter breadcrumb: Class → function → method
							local ok, ts = pcall(require, "nvim-treesitter")
							if not ok then
								return ""
							end
							return ts.statusline({
								type_patterns = { "class", "function", "method" },
								separator = " → ",
								indicator_size = 80, -- max width of the breadcrumb
								transform_fn = function(line)
									return line:gsub("%s*[%(%[].*$", "") -- strip args if you want
								end,
							})
						end,
						cond = function()
							-- only show when Treesitter is active for the buffer
							local ok, parsers = pcall(require, "nvim-treesitter.parsers")
							return ok and parsers.has_parser()
						end,
					},
				},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			extensions = { "nvim-tree", "quickfix", "trouble" },
		})
	end,
}
