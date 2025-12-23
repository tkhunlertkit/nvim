-- lua/plugins/telescope.lua
-- Fuzzy finder (Telescope) configuration

return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = "Telescope",
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local trouble = require("trouble.sources.telescope")

      telescope.setup({
        defaults = {
          previewer = false,
          prompt_prefix = "🔍 ",
          selection_caret = "❯ ",
          path_display = { "truncate" },
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-t>"] = trouble.open,
            },
            n = {
              ["<C-t>"] = trouble.open,
            },
          },
          file_ignore_patterns = { "node_modules", ".git", ".cache", "build", "dist" },
        },
        pickers = {
          find_files = {
            theme = "dropdown",
            previewer = true,
            hidden = true,
          },
          live_grep = {
            theme = "dropdown",
          },
          buffers = {
            theme = "dropdown",
            previewer = false,
            sort_mru = true,
            sort_lastused = true,
          },
          help_tags = {
            theme = "dropdown",
          },
          oldfiles = {
            theme = "dropdown",
          },
          commands = {
            theme = "dropdown",
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })

      -- Load extensions
      telescope.load_extension("fzf")
      telescope.load_extension("ui-select")
    end,
  },

  -- Live grep with arguments
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    lazy = true,
  },

  -- FZF native extension for better performance
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    lazy = true,
  },

  -- UI Select extension
  {
    "nvim-telescope/telescope-ui-select.nvim",
    lazy = true,
  },
}
