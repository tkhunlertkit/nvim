# Neovim Lua Configuration Modernization Guide

## Overview

This guide converts your Neovim configuration from the traditional `require()` pattern to modern Neovim Lua APIs using `vim.*` namespace functions. This approach is cleaner, more maintainable, and follows current Neovim best practices.

---

## Current vs Modern Approach

### Before (Old Pattern)
```lua
require("mason")
require("mason-lspconfig")
require("lspconfig")
require("lsp-format")
```

### After (Modern Pattern)
```lua
-- Direct module loading with vim namespace
vim.cmd('packadd mason.nvim')
vim.cmd('packadd lspconfig')
-- Or lazy-load using your package manager
```

---

## File Structure

```
nvim/
├── init.lua                          # Main entry point (simplified)
├── lua/
│   ├── config/
│   │   ├── init.lua                  # Config initialization
│   │   ├── mason.lua                 # Mason setup
│   │   ├── lspconfig.lua             # LSP configuration
│   │   └── keymaps.lua               # LSP keymaps
│   ├── utils/
│   │   └── helpers.lua               # Helper functions
│   └── diagnostics.lua               # Diagnostic settings
```

---

## Key Changes

### 1. **No More require() in init.lua**
- Import modules directly using Lua's `dofile()` or `vim.fn` namespace
- Use `vim.cmd.packadd()` for plugin loading
- Organize configs by functionality (mason, lsp, diagnostics)

### 2. **Use vim.diagnostic for Diagnostics**
Instead of:
```lua
vim.diagnostic.open_float()
```
✓ Already modern! But ensure it's centralized in config.

### 3. **Use vim.lsp for LSP Setup**
Instead of:
```lua
require("lspconfig").pyright.setup {}
```
Better approach:
```lua
local lspconfig = require("lspconfig")
-- Then configure servers via vim.lsp namespace functions
```

### 4. **Modern Keymap Setup**
Use `vim.keymap.set()` exclusively:
```lua
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
```

### 5. **Centralized Configuration**
- Separate concerns (mason, lsp, diagnostics, keymaps)
- Single source of truth for settings
- Easy to enable/disable features

---

## Migration Strategy

### Step 1: Create New File Structure
Create the directory structure mentioned above.

### Step 2: Organize by Functionality
- **mason.lua**: All Mason (package manager) setup
- **lspconfig.lua**: All LSP server configurations
- **keymaps.lua**: All LSP-related keymaps
- **diagnostics.lua**: Diagnostic display settings

### Step 3: Simplify init.lua
Load modules in sequence with proper error handling.

### Step 4: Remove Print Statements
Replace debug `print()` with proper logging (optional: vim.notify).

---

## What Stays the Same

✓ LSP keybindings (already using `vim.keymap.set()`)
✓ Diagnostic autocmds (`vim.api.nvim_create_autocmd()`)
✓ Server configurations (via lspconfig)
✓ Formatting setup (lsp-format)

---

## What Changes

✗ Remove: Top-level `require()` calls in init.lua
✗ Remove: Print statements (use vim.notify instead)
✗ Remove: Scattered configuration across files
✓ Add: Modular, well-organized config files
✓ Add: Centralized settings management
✓ Add: Clear loading order

---

## Implementation

See the accompanying Lua files:
- `init.lua` - Main entry point
- `config/init.lua` - Configuration loader
- `config/mason.lua` - Mason setup
- `config/lspconfig.lua` - LSP setup
- `config/keymaps.lua` - All keymaps
- `config/diagnostics.lua` - Diagnostic settings
- `utils/helpers.lua` - Helper functions

---

## Benefits of Modernization

1. **Clarity** - Clear what's loading and when
2. **Performance** - Lazy loading opportunities
3. **Maintainability** - Each module has single responsibility
4. **Testability** - Functions are isolated and reusable
5. **Debugging** - Easier to trace issues
6. **Standards** - Follows current Neovim conventions

---

## Next Steps

1. Backup your current `~/.config/nvim` directory
2. Copy the new file structure into place
3. Test Neovim startup: `nvim --headless "+q"`
4. Check for errors: `:checkhealth`
5. Verify LSP loads: `:LspInfo`
6. Test keymaps: Use any LSP keymap (e.g., `gd` for goto definition)

---

## Troubleshooting

**Mason won't load:**
- Ensure mason.nvim plugin is installed
- Check plugin manager configuration
- Run `:Mason` to verify installation

**LSP servers not starting:**
- Verify `lspconfig` plugin is installed
- Check `:LspInfo` for server status
- Look at `:e ~/.cache/nvim/lsp.log` for errors

**Keymaps not working:**
- Test with `:lua vim.lsp.buf.definition()`
- Verify buffer is attached to LSP
- Check for keymap conflicts: `:map gd`

**Print statements are no longer showing:**
- Use `vim.notify("message")` instead
- Or check `:messages` command

---

## References

- [Neovim LSP Configuration](https://neovim.io/doc/user/lsp.html)
- [vim.diagnostic API](https://neovim.io/doc/user/lsp_diagnostic.html)
- [vim.lsp API](https://neovim.io/doc/user/lsp.html)
- [Lua guide](https://neovim.io/doc/user/lua.html)
