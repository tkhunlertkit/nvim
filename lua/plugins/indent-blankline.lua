-- selene: allow(mixed_table)
-- lua/plugins/indent_blankline.lua
--
return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local ok, ibl = pcall(require, "ibl")
		if not ok then
			return
		end

		local hooks = require("ibl.hooks")

		local highlight = {
			"RainbowRed",
			"RainbowYellow",
			"RainbowBlue",
			"RainbowOrange",
			"RainbowGreen",
			"RainbowViolet",
			"RainbowCyan",
		}

		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			-- colors are now defined in lua/core/highlights.lua
			-- This jook just ensures groups exist when color scheme changes
		end)

		ibl.setup({
			indent = {
				highlight = highlight,
				char = "▏",
				tab_char = "▏",
			},
			scope = { highlight = highlight },
		})

		hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
	end,
}
