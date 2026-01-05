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
    { "<leader>c<leader>", mode = { "n", "v" }, desc = "Toggle comment" },
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

    -- Add toggle keymap for <leader>c<leader>
    local api = require("Comment.api")
    vim.keymap.set({ "n", "v" }, "<leader>c<leader>", function()
      api.toggle.linewise.current()
    end, { desc = "Toggle comment" })
  end,
}
