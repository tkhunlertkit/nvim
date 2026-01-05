-- ============================================================================
-- Undotree: Visualize undo history
-- Visualizes the undo tree to make it easy to browse and switch
-- ============================================================================

return {
  "mbbill/undotree",
  cmd = "UndotreeToggle",
  keys = {
    { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle undotree" },
  },
  config = function()
    vim.g.undotree_WindowLayout = 2
    vim.g.undotree_ShortIndicators = 1
    vim.g.undotree_SplitWidth = 30
    vim.g.undotree_SetFocusWhenToggle = 1
  end,
}
