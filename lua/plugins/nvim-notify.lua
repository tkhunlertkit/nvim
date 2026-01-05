-- selene: allow(mixed_table)
-- lua/plugins/vim_notify.lua

return {
	-- Notify (better notifications)
	"rcarriga/nvim-notify",
	lazy = true,
	config = function()
		require("notify").setup({
			background_colour = "#000000",
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
			on_open = function(win)
				vim.api.nvim_win_set_config(win, { zindex = 175 })
			end,
		})
		vim.notify = require("notify")
	end,
}
