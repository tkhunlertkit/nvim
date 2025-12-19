-- lua/plugins/editor.lua
-- Editor enhancements: file explorer, commenting, surround, etc.

return {
  -- File Explorer (NvimTree)
  {
    "nvim-tree/nvim-tree.lua",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile" },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
          side = "left",
          preserve_window_proportions = false,
        },
        renderer = {
          group_empty = true,
          special_files = { "Makefile", "README.md", "readme.md", ".env.local" },
          full_name = false,
          root_folder_label = ":~",
          icons = {
            git_placement = "signcolumn",
          },
        },
        sync_root_with_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
          ignore_list = {},
        },
        diagnostics = {
          enable = true,
          show_on_dirs = false,
        },
        git = {
          enable = true,
          ignore = false,
        },
        filters = {
          dotfiles = false,
          custom = { "node_modules", ".cache", ".git", "dist", "build" },
        },
      })
    end,
  },

  -- Comment plugin
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("Comment").setup({
        padding = true,
        sticky = true,
        ignore = nil,
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
  },

  -- Surround text (brackets, quotes, etc.)
  {
    "kylechui/nvim-surround",
    event = { "BufReadPost", "BufNewFile" },
    version = "*",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  -- Multiple cursors
  {
    "mg979/vim-visual-multi",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<C-d>",
        ["Find Subword Under"] = "<C-d>",
      }
    end,
  },

  -- Better undo tree
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    config = function()
      vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", { noremap = true, silent = true })
    end,
  },

  -- Project management
  {
    "ahmedkhalf/project.nvim",
    event = "VimEnter",
    config = function()
      require("project_nvim").setup({
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
        show_hidden = false,
        silent_chdir = true,
        scope_chdir = "global",
        datapath = vim.fn.stdpath("data"),
      })
      require("telescope").load_extension("projects")
    end,
  },

  -- Trouble (diagnostics list)
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    config = function()
      require("trouble").setup({
        position = "bottom",
        height = 10,
        width = 50,
        icons = true,
        mode = "workspace_diagnostics",
        fold_open = "v",
        fold_closed = ">",
        group = true,
        padding = true,
        action_keys = {
          close = "q",
          cancel = "<esc>",
          refresh = "r",
          jump = { "<cr>", "<tab>" },
          open_split = { "<c-x>" },
          open_vsplit = { "<c-v>" },
          open_tab = { "<c-t>" },
          jump_close = { "o" },
          toggle_mode = "m",
          switch_severity = "s",
          toggle_preview = "P",
          hover = "K",
          preview = "p",
          close_folds = { "zM", "zm" },
          open_folds = { "zR", "zr" },
          toggle_fold = { "zA", "za" },
          previous = "k",
          next = "j",
        },
        indent_lines = true,
        auto_open = false,
        auto_close = false,
        auto_preview = true,
        auto_fold = false,
        auto_jump = false,
        signs = {
          error = "❌",
          warning = "⚠",
          hint = "💡",
          information = "ℹ",
          other = "🔍",
        },
        use_diagnostic_signs = false,
      })

      vim.keymap.set("n", "<leader>xx", ":TroubleToggle<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>xw", ":TroubleToggle workspace_diagnostics<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>xd", ":TroubleToggle document_diagnostics<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>xq", ":TroubleToggle quickfix<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>xl", ":TroubleToggle loclist<CR>", { noremap = true, silent = true })
    end,
  },

  -- Todo comments
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup({
        signs = true,
        sign_priority = 8,
        keywords = {
          FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
          TEST = { icon = "⊘ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
        gui_style = {
          fg = "BOLD",
          bg = "NONE",
        },
        merge_keywords = true,
        highlight = {
          multiline = true,
          multiline_pattern = "^.",
          multiline_context = 10,
          before = "",
          keyword = "wide",
          after = "fg",
          pattern = [[.*<(KEYWORDS)\s*:]],
          comments_only = true,
          max_line_len = 400,
          exclude = {},
        },
        search = {
          command = "rg",
          args = { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column" },
          pattern = [[\b(KEYWORDS):]],
        },
      })
    end,
  },

  -- Smart splits window navigation
  {
    "mrjones2014/smart-splits.nvim",
    lazy = true,
    config = function()
      require("smart-splits").setup({
        ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" },
        ignored_buftypes = { "nofile", "quickfix", "prompt" },
        default_amount = 3,
        at_edge = "stop",
        move_cursor_same_row = false,
        cursor_follows_swapped_windows = true,
        resize_mode = {
          quit_key = "<ESC>",
          resize_keys = { "h", "j", "k", "l" },
          silent = false,
          hooks = {
            on_enter = nil,
            on_leave = nil,
          },
        },
        multiplexer_integration = nil,
        use_tmux_integration = false,
        tmux_commands = {
          new_pane = "split-window",
          horizontal_nav = "select-pane",
          vertical_nav = "select-pane",
        },
      })
    end,
  },
}