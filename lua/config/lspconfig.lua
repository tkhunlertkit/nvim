-- lua/config/lspconfig.lua
-- Modern LSP configuration using vim.lsp namespace
-- Configures language servers and their capabilities
-- Reference: https://github.com/neovim/nvim-lspconfig

local M = {}

-- Load required modules
local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
  vim.notify("nvim-lspconfig is not installed.", vim.log.levels.ERROR)
  return M
end

local lsp_format_ok, lsp_format = pcall(require, "lsp-format")
if not lsp_format_ok then
  vim.notify("lsp-format plugin is not installed. Install for auto-formatting.", vim.log.levels.WARN)
  lsp_format = nil
end

-- ============================================================================
-- Common on_attach function
-- This is called when a language server attaches to a buffer
-- ============================================================================
local function on_attach_default(client, bufnr)
  -- Enable code completion (omnifunc)
  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
  
  -- Attach lsp-format if available
  if lsp_format then
    lsp_format.on_attach(client, bufnr)
  end
end

-- ============================================================================
-- Language Server Configurations
-- ============================================================================

-- Python Language Server (Pyright)
lspconfig.pyright.setup({
  on_attach = on_attach_default,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
        typeCheckingMode = "off",       -- Change to "basic", "standard", or "strict" if needed
        autoImportCompletions = true,
      },
    },
  },
})

-- TypeScript/JavaScript Language Server
-- Note: ts_ls is the modern name (tsserver is deprecated)
lspconfig.ts_ls.setup({
  on_attach = on_attach_default,
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  init_options = {
    preferences = {
      disableSuggestions = false,
    },
  },
})

-- Lua Language Server
lspconfig.lua_ls.setup({
  on_attach = on_attach_default,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        globals = { "vim" },  -- Recognize 'vim' global
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),  -- Lua API
      },
    },
  },
})

-- ============================================================================
-- EFM Language Server (Formatter/Linter aggregator)
-- This allows multiple formatters and linters per language
-- ============================================================================
lspconfig.efm.setup({
  on_attach = on_attach_default,
  init_options = { documentFormatting = true },
  settings = {
    rootMarkers = { ".git/", ".gitignore" },
    languages = {
      -- Lua formatting
      lua = {
        { formatCommand = "lua-format -i", formatStdin = true },
      },
      -- Python formatting
      python = {
        { formatCommand = "isort --quiet -", formatStdin = true },
        { formatCommand = "black --quiet --line-length 120 -", formatStdin = true },
      },
      -- JavaScript/TypeScript formatting
      javascript = {
        { formatCommand = "prettier --stdin-filepath ${INPUT}", formatStdin = true },
      },
      typescript = {
        { formatCommand = "prettier --stdin-filepath ${INPUT}", formatStdin = true },
      },
    },
    log = {
      level = "debug",
      file = "/home/tkhunlertkit/efmlog.txt",  -- Adjust path as needed
    },
  },
})

-- ============================================================================
-- LSP Global Capabilities
-- These are capabilities supported by the client
-- ============================================================================
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Modern Neovim (0.10+) supports these capabilities
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = { dynamicRegistration = false }

-- Update all servers to use these capabilities
for _, server in ipairs({ "pyright", "ts_ls", "lua_ls", "efm" }) do
  if lspconfig[server] then
    lspconfig[server].setup({
      capabilities = capabilities,
    })
  end
end

return M
