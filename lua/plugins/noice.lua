-- lua/plugins/noice.lua

return {
	-- Noice (better messages, command line UI)
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	config = function()
		require("noice").setup({
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			routes = {
				{ filter = { event = "msg_show", kind = "search_count" }, opts = { skip = true } },
			},
			presets = {
				lsp_doc_border = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = true,
				bottom_search = true,
			},
			notify = {
				enable = false,
			},
		})
	end,
}
