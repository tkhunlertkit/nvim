-- ============================================================================
-- Web DevIcons: File icons
-- Icons for filetypes in Neovim
-- ============================================================================

return {
  "nvim-tree/nvim-web-devicons",
  lazy = true,
  opts = {
    override = {
      default_icon = {
        icon = "",
        name = "Default",
      },
    },
  },
}
