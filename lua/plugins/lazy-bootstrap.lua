-- ============================================================================
-- Lazy.nvim Bootstrap and Configuration
-- This file sets up lazy.nvim and imports all plugin specs
-- ============================================================================

-- Setup lazy.nvim with all plugin specifications
require("lazy").setup({
  -- Automatically import all lua files in lua/plugins/ directory
  -- Each file should return a plugin spec table
  spec = {
    { import = "plugins.colorscheme" },
    { import = "plugins.lualine" },
    { import = "plugins.bufferline" },
    { import = "plugins.indent-blankline" },
    { import = "plugins.noice" },
    { import = "plugins.notify" },
    { import = "plugins.snacks" },
    { import = "plugins.which-key" },
    { import = "plugins.web-devicons" },
    { import = "plugins.nvim-tree" },
    { import = "plugins.comment" },
    { import = "plugins.surround" },
    { import = "plugins.autopairs" },
    { import = "plugins.trouble" },
    { import = "plugins.todo-comments" },
    { import = "plugins.undotree" },
    { import = "plugins.toggleterm" },
    { import = "plugins.treesitter" },
    { import = "plugins.telescope" },
    { import = "plugins.lsp" },
    { import = "plugins.mason" },
    { import = "plugins.cmp" },
    { import = "plugins.gitsigns" },
    { import = "plugins.fugitive" },
    { import = "plugins.dap" },
    { import = "plugins.plenary" },
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
    wk.add({
      { "<leader>f", group = "find" },
      { "<leader>g", group = "git" },
      { "<leader>l", group = "lsp" },
      { "<leader>x", group = "diagnostics" },
      { "<leader>b", group = "buffer" },
      { "<leader>s", group = "split/search" },
      { "<leader>t", group = "terminal" },
      { "<leader>d", group = "debug" },
      { "<leader>c", group = "code" },
      { "<leader>h", group = "git hunk" },
    })
  end
end)
