-- lua/plugins/lsp.lua
-- LSP (Language Server Protocol) configuration
-- Compatible with Neovim 0.11.5+

vim.env.NVIM_SUPPRESS_LSPCONFIG_DEPRECATION = "1"

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      local lspconfig = require("lspconfig")

      -- Lua Language Server
      lspconfig.lua_ls.setup({
        on_init = function(client)
          local path = client.workspace_folders[1].name
          if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
            return
          end

          client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
            Lua = {
              runtime = {
                version = "LuaJIT",
              },
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME,
                },
              },
            },
          })
        end,
        settings = {
          Lua = {},
        },
      })

      -- Python Language Server (Pyright)
      lspconfig.pyright.setup({})

      -- TypeScript/JavaScript Language Server
      lspconfig.ts_ls.setup({
        init_options = {
          preferences = {
            disableSuggestions = false,
          },
        },
      })

      -- JSON Language Server
      lspconfig.jsonls.setup({
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })

      -- YAML Language Server
      lspconfig.yamlls.setup({
        settings = {
          yaml = {
            validate = true,
            schemaStore = {
              enable = true,
              url = "https://www.schemastore.org/api/json/catalog.json",
            },
          },
        },
      })

      -- Go Language Server
      lspconfig.gopls.setup({})

      -- Rust Analyzer
      lspconfig.rust_analyzer.setup({
        settings = {
          ["rust-analyzer"] = {
            diagnostics = {
              enable = true,
            },
          },
        },
      })

      -- Bash Language Server
      lspconfig.bashls.setup({})

      -- SQL Language Server
      lspconfig.sqlls.setup({
        settings = {
          sqlls = {
            connections = {
              -- Configure your database connections here if needed
              -- Example:
              -- {
              --   name = "local",
              --   driver = "postgres",
              --   server = "localhost",
              --   port = 5432,
              --   user = "user",
              --   database = "mydb",
              -- }
            },
          },
        },
      })

      -- HTML/CSS Language Server
      lspconfig.html.setup({})
      lspconfig.cssls.setup({})

      -- ========================================================================
      -- Capability enhancements (completion, etc)
      -- ========================================================================

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Add capabilities to all servers above by re-running setup with capabilities
      local servers = {
        "lua_ls",
        "pyright",
        "ts_ls",
        "jsonls",
        "yamlls",
        "gopls",
        "rust_analyzer",
        "bashls",
        "sqlls",
        "html",
        "cssls",
      }

      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          capabilities = capabilities,
        })
      end
    end,
  },

  -- JSON Schema Store (for better JSON/YAML validation)
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false,
  },

  -- LSP Progress UI (loading indicator)
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      notification = {
        override_vim_notify = true,
      },
    },
  },
}
