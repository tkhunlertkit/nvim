-- ============================================================================
-- Surround: Add/change/delete surrounding delimiter pairs
-- Surround selections with quotes, brackets, tags, etc.
-- ============================================================================

return {
  "kylechui/nvim-surround",
  version = "*",
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "ys",
        normal_cur = "yss",
        normal_line = "yS",
        normal_cur_line = "ySS",
        visual = "S",
        visual_line = "gS",
        delete = "ds",
        change = "cs",
        change_line = "cS",
      },
    })
  end,
}

-- Usage examples:
-- ys + motion + char: Surround text with char
--   ysiw"  -> surround inner word with "
--   yss)   -> surround entire line with ()
--
-- cs + old + new: Change surrounding
--   cs"'   -> change " to '
--   cs({   -> change ( to { with space
--
-- ds + char: Delete surrounding
--   ds"    -> remove surrounding "
--   dst    -> remove surrounding HTML tag
--
-- Visual mode: S + char
--   Select text, press S, then "  -> surround selection with "
