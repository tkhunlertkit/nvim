-- lua/core/highlights.lua
local M = {}

-- Shared color palette (Nord-inspired, matches your hex values)
local colors = {
	red = "#E06C75",
	yellow = "#E5C07B",
	blue = "#61AFEF",
	orange = "#D19A66",
	green = "#98C379",
	violet = "#C678DD",
	cyan = "#56B6C2",
}

function M.setup()
	-- Rainbow delimiter groups
	vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = colors.red })
	vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = colors.yellow })
	vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = colors.blue })
	vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = colors.orange })
	vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = colors.green })
	vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = colors.violet })
	vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = colors.cyan })

	-- Indent-blankline groups (same palette)
	vim.api.nvim_set_hl(0, "RainbowRed", { fg = colors.red })
	vim.api.nvim_set_hl(0, "RainbowYellow", { fg = colors.yellow })
	vim.api.nvim_set_hl(0, "RainbowBlue", { fg = colors.blue })
	vim.api.nvim_set_hl(0, "RainbowOrange", { fg = colors.orange })
	vim.api.nvim_set_hl(0, "RainbowGreen", { fg = colors.green })
	vim.api.nvim_set_hl(0, "RainbowViolet", { fg = colors.violet })
	vim.api.nvim_set_hl(0, "RainbowCyan", { fg = colors.cyan })

	-- Highlight-undo group
	vim.api.nvim_set_hl(0, "HighlightUndo", {
		bg = "#434C5E",
		-- fg = "#88C0D0",
		fg = colors.cyan,
	})
end

return M
