-- ============================================================================
-- Comment: Smart commenting
-- Smart and powerful comment plugin for neovim
-- ============================================================================

return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    { "gcc", mode = "n", desc = "Comment line" },
    { "gc", mode = { "n", "v" }, desc = "Comment" },
    { "gbc", mode = "n", desc = "Block comment line" },
    { "gb", mode = { "n", "v" }, desc = "Block comment" },
  },
  config = function()
    require("Comment").setup({
      padding = true,
      sticky = true,
      ignore = "^$", -- Ignore empty lines
      toggler = {
        line = "gcc",
        block = "gbc",
      },
      opleader = {
        line = "gc",
        block = "gb",
      },
      extra = {
        above = "gcO",
        below = "gco",
        eol = "gcA",
      },
      mappings = {
        basic = true,
        extra = true,
      },
      pre_hook = nil,
      post_hook = nil,
    })
  end,
}
