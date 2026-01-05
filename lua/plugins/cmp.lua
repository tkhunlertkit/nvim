-- ============================================================================
-- nvim-cmp: Completion engine
-- A completion plugin for neovim coded in Lua
-- ============================================================================

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    -- Snippet engine
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
      dependencies = {
        "rafamadriz/friendly-snippets", -- Useful snippets collection
      },
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    -- Completion sources
    "saadparwaiz1/cmp_luasnip",     -- Snippet completions
    "hrsh7th/cmp-nvim-lsp",         -- LSP completions
    "hrsh7th/cmp-buffer",           -- Buffer completions
    "hrsh7th/cmp-path",             -- Path completions
    "hrsh7th/cmp-cmdline",          -- Command line completions
    "hrsh7th/cmp-nvim-lua",         -- Neovim Lua API completions
    -- Icons
    "onsails/lspkind.nvim",         -- VSCode-like pictograms
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- ========================================================================
    -- Helper function to check if there's words before cursor
    -- ========================================================================
    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    -- ========================================================================
    -- Main completion setup
    -- ========================================================================
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },

      mapping = cmp.mapping.preset.insert({
        -- Navigate completion menu
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),

        -- Tab and Shift-Tab for snippet navigation and completion
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),

      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
        { name = "nvim_lua", priority = 500 },
        { name = "buffer", priority = 250 },
        { name = "path", priority = 100 },
      }),

      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
          before = function(entry, vim_item)
            return vim_item
          end,
        }),
      },

      experimental = {
        ghost_text = true, -- Show preview of completion
      },

      -- Performance
      performance = {
        debounce = 60,
        throttle = 30,
        fetching_timeout = 500,
      },
    })

    -- ========================================================================
    -- Command line completion
    -- ========================================================================
    
    --  search completion
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    --  command completion
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })

    -- ========================================================================
    -- Snippet key mappings (outside of completion menu)
    -- ========================================================================
    vim.keymap.set({ "i", "s" }, "<C-n>", function()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { silent = true })

    vim.keymap.set({ "i", "s" }, "<C-p>", function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { silent = true })
  end,
}
