-- ============================================================================
-- LSP: Language Server Protocol
-- Provides IDE-like features: completion, diagnostics, go-to-definition, etc.
-- ============================================================================

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- ========================================================================
    -- Diagnostic Configuration
    -- ========================================================================
    local signs = {
      { name = "DiagnosticSignError", text = "" },
      { name = "DiagnosticSignWarn", text = "" },
      { name = "DiagnosticSignHint", text = "" },
      { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
      vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    vim.diagnostic.config({
      virtual_text = {
        prefix = "●",
        spacing = 4,
      },
      signs = true,
      update_in_insert = false,
      underline = true,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })

    -- ========================================================================
    -- LSP Keymaps (set on buffer attach)
    -- ========================================================================
    local on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, silent = true }

      -- Helper to set keymap with description
      local keymap = function(mode, lhs, rhs, desc)
        opts.desc = desc
        vim.keymap.set(mode, lhs, rhs, opts)
      end

      -- Navigation
      keymap("n", "gd", vim.lsp.buf.definition, "Go to definition")
      keymap("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
      keymap("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
      keymap("n", "gr", vim.lsp.buf.references, "Go to references")
      keymap("n", "gt", vim.lsp.buf.type_definition, "Go to type definition")

      -- Documentation
      keymap("n", "K", vim.lsp.buf.hover, "Hover documentation")
      keymap("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
      keymap("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help")

      -- Code actions
      keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
      keymap("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
      keymap("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
      end, "Format buffer")

      -- Diagnostics
      keymap("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
      keymap("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
      keymap("n", "<leader>d", vim.diagnostic.open_float, "Show diagnostic")
      keymap("n", "<leader>dl", vim.diagnostic.setloclist, "Diagnostic to location list")

      -- Workspace
      keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
      keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
      keymap("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, "List workspace folders")

      -- Highlight references under cursor
      if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
        vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          group = "lsp_document_highlight",
          buffer = bufnr,
          callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
          group = "lsp_document_highlight",
          buffer = bufnr,
          callback = vim.lsp.buf.clear_references,
        })
      end
    end

    -- ========================================================================
    -- LSP Capabilities (for completion)
    -- ========================================================================
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- ========================================================================
    -- Default LSP Config
    -- ========================================================================
    local default_config = {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    -- ========================================================================
    -- Language Server Configurations
    -- ========================================================================

    -- Lua
    lspconfig.lua_ls.setup(vim.tbl_deep_extend("force", default_config, {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand("/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    }))

    -- Python
    lspconfig.pyright.setup(default_config)

    -- TypeScript/JavaScript
    lspconfig.ts_ls.setup(default_config)

    -- Go
    lspconfig.gopls.setup(vim.tbl_deep_extend("force", default_config, {
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
          gofumpt = true,
        },
      },
    }))

    -- Rust
    lspconfig.rust_analyzer.setup(vim.tbl_deep_extend("force", default_config, {
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = {
            command = "clippy",
          },
          cargo = {
            allFeatures = true,
          },
        },
      },
    }))

    -- Bash
    lspconfig.bashls.setup(default_config)

    -- JSON
    lspconfig.jsonls.setup(default_config)

    -- YAML
    lspconfig.yamlls.setup(default_config)

    -- HTML
    lspconfig.html.setup(default_config)

    -- CSS
    lspconfig.cssls.setup(default_config)

    -- Tailwind CSS
    lspconfig.tailwindcss.setup(default_config)

    -- Docker
    lspconfig.dockerls.setup(default_config)

    -- Markdown
    lspconfig.marksman.setup(default_config)

    -- ========================================================================
    -- Configure hover and signature help borders
    -- ========================================================================
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "rounded",
    })
  end,
}

