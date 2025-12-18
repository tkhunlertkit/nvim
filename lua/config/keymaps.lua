-- lua/config/keymaps.lua
-- Modern keymap setup using vim.keymap.set()
-- All LSP-related keybindings configured here
-- Reference: :help vim.keymap.set()

local M = {}

-- ============================================================================
-- Global Diagnostic Keymaps
-- These work without an LSP server attached (for viewing general diagnostics)
-- ============================================================================

-- Open float window with diagnostic information
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {
  noremap = true,
  silent = true,
  desc = "Show diagnostic in float",
})

-- Go to previous diagnostic
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {
  noremap = true,
  silent = true,
  desc = "Go to previous diagnostic",
})

-- Go to next diagnostic
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {
  noremap = true,
  silent = true,
  desc = "Go to next diagnostic",
})

-- Open diagnostic list in location list
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, {
  noremap = true,
  silent = true,
  desc = "Set location list with diagnostics",
})

-- ============================================================================
-- LSP Buffer Keymaps
-- These are set when an LSP server attaches to a buffer via LspAttach autocmd
-- ============================================================================

-- Create autocommand group for LSP keymaps
local lsp_group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })

-- Register LspAttach autocommand
vim.api.nvim_create_autocmd("LspAttach", {
  group = lsp_group,
  callback = function(ev)
    -- Get the buffer number
    local bufnr = ev.buf
    
    -- Helper to create keymap options for this buffer
    local function buf_keymap(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, {
        buffer = bufnr,
        noremap = true,
        silent = true,
        desc = desc,
      })
    end
    
    -- ====================================================================
    -- Navigation & Definition Keymaps
    -- ====================================================================
    
    -- Go to declaration (where variable is declared, not implemented)
    buf_keymap("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    
    -- Go to definition (primary location where identifier is defined)
    buf_keymap("n", "gd", vim.lsp.buf.definition, "Go to definition")
    
    -- Go to implementation (where interface/abstract is implemented)
    buf_keymap("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
    
    -- Go to type definition
    buf_keymap("n", "gy", vim.lsp.buf.type_definition, "Go to type definition")
    
    -- Find all references to symbol
    buf_keymap("n", "gr", vim.lsp.buf.references, "Find references")
    
    -- ====================================================================
    -- Information Keymaps
    -- ====================================================================
    
    -- Show hover documentation (tooltip)
    buf_keymap("n", "K", vim.lsp.buf.hover, "Show hover information")
    
    -- Show signature help (parameter information while typing)
    buf_keymap("n", "<C-k>", vim.lsp.buf.signature_help, "Show signature help")
    
    -- ====================================================================
    -- Code Actions & Refactoring
    -- ====================================================================
    
    -- Rename symbol
    buf_keymap("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
    
    -- Code actions (context menu for available fixes)
    buf_keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
    
    -- ====================================================================
    -- Formatting
    -- ====================================================================
    
    -- Format buffer (async to not block UI)
    buf_keymap("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, "Format buffer")
    
    -- ====================================================================
    -- Workspace Folder Management
    -- ====================================================================
    
    -- Add current working directory to workspace
    buf_keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
    
    -- Remove workspace folder
    buf_keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
    
    -- List all workspace folders
    buf_keymap("n", "<leader>wl", function()
      vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()), vim.log.levels.INFO)
    end, "List workspace folders")
    
    -- ====================================================================
    -- Completion Setup
    -- ====================================================================
    
    -- Enable completion with omnifunc
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    
    -- ====================================================================
    -- Highlight Configuration
    -- ====================================================================
    
    -- Get the client that attached
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    
    -- Enable document highlight on cursor hold (highlights all references)
    if client and client.server_capabilities.documentHighlightProvider then
      local highlight_group = vim.api.nvim_create_augroup("lsp-highlight-" .. bufnr, {})
      
      vim.api.nvim_create_autocmd("CursorHold", {
        group = highlight_group,
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
        desc = "Highlight references under cursor",
      })
      
      vim.api.nvim_create_autocmd("CursorMoved", {
        group = highlight_group,
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
        desc = "Clear highlight on cursor move",
      })
    end
    
  end,
})

-- ============================================================================
-- Quick Reference for Keymaps
-- ============================================================================
-- Navigation:
--   gd   - Go to definition
--   gD   - Go to declaration
--   gy   - Go to type definition
--   gi   - Go to implementation
--   gr   - Find references
-- 
-- Information:
--   K    - Hover documentation
--   <C-k> - Signature help
--
-- Actions:
--   <leader>rn - Rename
--   <leader>ca - Code action
--   <leader>f  - Format
--
-- Workspace:
--   <leader>wa - Add workspace folder
--   <leader>wr - Remove workspace folder
--   <leader>wl - List workspace folders
--
-- Diagnostics:
--   <leader>e - Show diagnostic float
--   [d       - Previous diagnostic
--   ]d       - Next diagnostic
--   <leader>q - Set location list

return M
