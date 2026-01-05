-- selene: allow(mixed_table)
-- lua/plugins/which-key.lua
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-mini/mini.icons", version = false },
	opts = {
		plugins = { spelling = true },
		win = { border = "rounded" },
		-- Optional: delay after <leader> before popup
		triggers = {
			{ "<leader>" },
			{ "g" },
			{ "]" },
			{ "[" },
		},
	},
}
