-- selene: allow(mixed_table)
-- lua/plugins/rainbow_delimiters.lua

return {
	"HiPhish/rainbow-delimiters.nvim",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		-- choose highlight groups
		vim.g.rainbow_delimiters = {
			highlight = {
				"RainbowDelimiterRed",
				"RainbowDelimiterYellow",
				"RainbowDelimiterBlue",
				"RainbowDelimiterOrange",
				"RainbowDelimiterGreen",
				"RainbowDelimiterViolet",
				"RainbowDelimiterCyan",
			},
		}

		-- Colors are defined in lua/core/highlights.lua
	end,
}
