-- lua/plugins/lsp.lua

-- LSP (Language Server Protocol) configuration
-- Using NEW vim.lsp.config() API (replaces deprecated setup())
-- Compatible with Neovim 0.11.5+

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Use vim.lsp.enable() with capabilities INSTEAD of deprecated .setup()
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

    -- Configure all servers with new API
    for _, server in ipairs(servers) do
      vim.lsp.config(server, {
        cmd = lspconfig[server].document_config.default_config.cmd,
        root_markers = lspconfig[server].document_config.default_config.root_dir,
        filetypes = lspconfig[server].document_config.default_config.filetypes,
        capabilities = capabilities,
      })
    end

    -- Enable all servers
    for _, server in ipairs(servers) do
      vim.lsp.enable(server)
    end

    -- Special Lua LS config
    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
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
      },
    })
    vim.lsp.enable("lua_ls")

    -- JSON LS with schema store
    vim.lsp.config("jsonls", {
      capabilities = capabilities,
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    })
    vim.lsp.enable("jsonls")

    -- YAML LS with schema store
    vim.lsp.config("yamlls", {
      capabilities = capabilities,
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
    vim.lsp.enable("yamlls")

    -- TypeScript LS config
    vim.lsp.config("ts_ls", {
      capabilities = capabilities,
      init_options = {
        preferences = {
          disableSuggestions = false,
        },
      },
    })
    vim.lsp.enable("ts_ls")

    -- Rust Analyzer config
    vim.lsp.config("rust_analyzer", {
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          diagnostics = {
            enable = true,
          },
        },
      },
    })
    vim.lsp.enable("rust_analyzer")

    -- SQL LS config
    vim.lsp.config("sqlls", {
      capabilities = capabilities,
      settings = {
        sqlls = {
          connections = {},
        },
      },
    })
    vim.lsp.enable("sqlls")

    -- LspAttach for keymaps (runs when an LSP attaches to a buffer)
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local bufnr = args.buf

        -- Your LSP keymaps are already in core/keymaps.lua
        -- They will work with any attached LSP
      end,
    })
  end,
}

-- JSON Schema Store (for better JSON/YAML validation)
{
  "b0o/SchemaStore.nvim",
  lazy = true,
  version = false,
}

-- LSP Progress UI (loading indicator)
{
  "j-hui/fidget.nvim",
  event = "LspAttach",
  opts = {
    notification = {
      override_vim_notify = true,
    },
  },
}