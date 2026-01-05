-- selene: allow(mixed_table)
-- lua/plugins/sleuth.lua

return {
	"tpope/vim-sleuth",
	event = { "BufReadPost", "BufNewFile" },
}
