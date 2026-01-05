-- ============================================================================
-- NvimTree: File Explorer
-- A file explorer tree for neovim written in lua
-- ============================================================================

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile" },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
    { "<leader>ef", "<cmd>NvimTreeFindFile<CR>", desc = "Find file in explorer" },
  },
  opts = {
    disable_netrw = true,
    hijack_netrw = true,
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = true,
    },
    view = {
      width = 30,
      side = "left",
      number = false,
      relativenumber = false,
    },
    renderer = {
      highlight_git = true,
      highlight_opened_files = "name",
      indent_markers = {
        enable = true,
      },
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
        glyphs = {
          default = "",
          symlink = "",
          folder = {
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
            symlink_open = "",
          },
          git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "",
            ignored = "◌",
          },
        },
      },
    },
    filters = {
      dotfiles = false,
      custom = { "^.git$", "node_modules", ".cache" },
    },
    actions = {
      open_file = {
        quit_on_open = false,
        window_picker = {
          enable = true,
        },
      },
    },
    git = {
      enable = true,
      ignore = false,
    },
  },
}
