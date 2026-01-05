-- ============================================================================
-- Fugitive: Git integration
-- A Git wrapper so awesome, it should be illegal
-- ============================================================================

return {
  "tpope/vim-fugitive",
  cmd = {
    "G",
    "Git",
    "Gdiffsplit",
    "Gread",
    "Gwrite",
    "Ggrep",
    "GMove",
    "GDelete",
    "GBrowse",
    "GRemove",
    "GRename",
    "Glgrep",
    "Gedit",
  },
  keys = {
    { "<leader>gs", "<cmd>Git<CR>", desc = "Git status" },
    { "<leader>gd", "<cmd>Gdiffsplit<CR>", desc = "Git diff" },
    { "<leader>gw", "<cmd>Gwrite<CR>", desc = "Git write (stage)" },
    { "<leader>gp", "<cmd>Git push<CR>", desc = "Git push" },
    { "<leader>gP", "<cmd>Git pull<CR>", desc = "Git pull" },
    { "<leader>gB", "<cmd>Git blame<CR>", desc = "Git blame" },
  },
}
