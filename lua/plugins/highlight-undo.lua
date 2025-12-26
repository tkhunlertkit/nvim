-- lua/plugins/highlight-undo.lua

return {
	"tzachar/highlight-undo.nvim",
	event = { "BufReadPost", "BufNewFile" }, -- load when editing files
	opts = {
		hlgroup = "HighlightUndo", -- highlight group to use
		duration = 300, -- ms to keep highlight
		pattern = { "*" }, -- which buffers to attach to
		ignored_filetypes = { "neo-tree", "fugitive", "TelescopePrompt", "mason", "lazy" },
	},
}
