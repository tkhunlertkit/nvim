-- ============================================================================
-- Colorscheme: Nord
-- Arctic, north-bluish color palette
-- ============================================================================

return {
  "arcticicestudio/nord-vim",
  lazy = false,
  priority = 1000, -- Load before other plugins
  config = function()
    -- Nord configuration options
    vim.g.nord_cursor_line_number_background = 1
    vim.g.nord_uniform_status_lines = 1
    vim.g.nord_bold_vertical_split_line = 1
    vim.g.nord_uniform_diff_background = 1
    vim.g.nord_bold = 1
    vim.g.nord_italic = 1
    vim.g.nord_italic_comments = 1
    vim.g.nord_underline = 1

    -- Apply colorscheme
    vim.cmd([[colorscheme nord]])
  end,
}
