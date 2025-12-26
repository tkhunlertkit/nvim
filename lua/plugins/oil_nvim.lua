-- lua/plugins/oil_nvim.lua

return {
	-- Oil (file explorer as a buffer)
	"stevearc/oil.nvim",
	cmd = "Oil",
	config = function()
		require("oil").setup({
			columns = { "icon" },
			buf_set_name0 = function(bufnr, bufname)
				vim.api.nvim_buf_set_name(bufnr, bufname)
			end,
			default_file_explorer = false,
			restore_win_options = true,
			skip_confirm_for_simple_edits = false,
			prompt_save_on_select_new_fs = true,
			cleanup_on_quit = false,
			lsp_file_methods = {
				enabled = false,
				timeout_ms = 1000,
				autosave_changes = false,
			},
			constrain_cursor = "editable",
			watch_for_changes = false,
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<C-s>"] = "actions.select_vsplit",
				["<C-h>"] = "actions.select_split",
				["<C-t>"] = "actions.select_tab",
				["<C-p>"] = "actions.preview",
				["<C-c>"] = "actions.close",
				["q"] = "actions.close",
				["<C-l>"] = "actions.refresh",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = "actions.tcd",
				["gs"] = "actions.change_sort",
				["gx"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
				["g\\"] = "actions.toggle_trash",
			},
		})
	end,
}
