-- ============================================================================
-- Noice: Better UI for messages, cmdline and popupmenu
-- Replaces the UI for messages, cmdline and the popupmenu
-- ============================================================================

return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
          },
        },
        view = "mini",
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = true,
    },
  },
  keys = {
    { "<leader>sn", "<cmd>Noice<CR>", desc = "Noice messages" },
    { "<leader>sl", "<cmd>Noice last<CR>", desc = "Noice last message" },
    { "<leader>sh", "<cmd>Noice history<CR>", desc = "Noice history" },
  },
}
