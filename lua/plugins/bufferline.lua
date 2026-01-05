-- ============================================================================
-- Bufferline: Buffer tabs
-- Beautiful and functional buffer tabs
-- ============================================================================

return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  keys = {
    { "<leader>bp", "<cmd>BufferLineTogglePin<CR>", desc = "Toggle pin buffer" },
    { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    { "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
    { "<leader>br", "<cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
    { "<leader>bl", "<cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
    { "[b", "<cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
    { "]b", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
  },
  config = function()
    require("bufferline").setup({
      options = {
        themable = true,
        numbers = "none",
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,
        indicator = {
          icon = "▎",
          style = "icon",
        },
        buffer_close_icon = "",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 18,
        max_prefix_length = 15,
        truncate_names = true,
        tab_size = 18,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "center",
            separator = true,
          },
        },
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        show_duplicate_prefix = true,
        persist_buffer_sort = true,
        separator_style = "thin",
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        hover = {
          enabled = false,
          delay = 200,
          reveal = { "close" },
        },
        sort_by = "insert_after_current",
      },
      -- Nord theme integration - use simple highlights without nord.bufferline
      highlights = {
        fill = {
          bg = "#2E3440",
        },
        background = {
          bg = "#2E3440",
        },
        buffer_selected = {
          bold = true,
          italic = false,
        },
      },
    })
  end,
}
