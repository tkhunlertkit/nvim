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

return
-- Statusline (lualine)
{
	"nvim-lualine/lualine.nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				always_show_tabline = false,
				icons_enabled = true,
				theme = "nord",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {},
				always_divide_middle = true,
				globalstatus = false,
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
			tabline = {},
			extensions = { "nvim-tree", "quickfix", "trouble" },
		})
	end,
}
