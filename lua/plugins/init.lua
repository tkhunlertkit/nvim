-- ============================================================================
-- Plugin Configuration Bootstrap
-- Loads all plugin specs and configures lazy.nvim
-- ============================================================================

-- Setup lazy.nvim with all plugin specifications
require("lazy").setup({
  -- Import all plugin specifications from lua/plugins/*.lua
  -- Each file in lua/plugins/ (except init.lua) will be loaded automatically
  spec = {
    { import = "plugins" },
  },

  -- Lazy.nvim configuration
  defaults = {
    lazy = false,    -- Plugins are not lazy-loaded by default
    version = false, -- Don't use version="*" by default
  },

  -- UI configuration
  ui = {
    border = "rounded",
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },

  -- Performance settings
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      -- Disable some built-in plugins we don't need
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },

  -- Change detection
  change_detection = {
    enabled = true,
    notify = false, -- Don't notify on every config change
  },

  -- Plugin installation settings
  install = {
    colorscheme = { "nord" }, -- Try to load this colorscheme during install
  },

  -- Checker settings
  checker = {
    enabled = false, -- Don't automatically check for plugin updates
    notify = false,
  },
})

-- Set up which-key groups after plugins are loaded
vim.schedule(function()
  local wk_ok, wk = pcall(require, "which-key")
  if wk_ok then
    wk.register({
      { "<leader>f", group = "+find" },
      { "<leader>g", group = "+git" },
      { "<leader>l", group = "+lsp" },
      { "<leader>x", group = "+diagnostics" },
      { "<leader>b", group = "+buffer" },
      { "<leader>s", group = "+split/search" },
      { "<leader>t", group = "+terminal" },
      { "<leader>d", group = "+debug" },
      { "<leader>c", group = "+code" },
    })
  end
end)
