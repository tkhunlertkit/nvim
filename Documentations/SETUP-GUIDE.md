# Neovim Config Setup Guide

## File Organization

This guide explains what each file does and how to organize your Neovim configuration.

### Root Directory (`~/.config/nvim/`)

```
init.lua              -- Entry point, requires core and plugins
.gitignore           -- Git ignore patterns
README.md            -- Main documentation
```

### Core Configuration (`lua/core/`)

**Purpose**: Settings, keybindings, and autocommands that apply globally.

| File | Purpose |
|------|---------|
| `init.lua` | Loads all core modules |
| `options.lua` | Global editor options (tabs, indentation, display, etc.) |
| `keymaps.lua` | All keybindings using `vim.keymap.set()` |
| `autocmds.lua` | Autocommands (like "highlight on yank") |

**How to customize:**
- Add new options to `options.lua`
- Add keybindings to `keymaps.lua`
- Add new autocommands to `autocmds.lua`

### Plugin Configuration (`lua/plugins/`)

**Purpose**: Plugin specifications and configurations for lazy.nvim.

| File | Purpose |
|------|---------|
| `init.lua` | Bootstrap lazy.nvim and load plugin specs |
| `lsp.lua` | LSP servers (Lua, Python, TypeScript, etc.) |
| `cmp.lua` | Completion engine (nvim-cmp) |
| `treesitter.lua` | Syntax highlighting and text objects |
| `telescope.lua` | Fuzzy finder |
| `ui.lua` | UI enhancements (colorscheme, statusline, etc.) |
| `editor.lua` | Editor tools (file explorer, comments, etc.) |
| `others.lua` | Additional useful plugins |

**Plugin Spec Format:**

```lua
return {
  {
    "owner/plugin-name",
    -- When to load: event, cmd, ft, etc.
    event = { "BufReadPost", "BufNewFile" },
    -- Dependencies
    dependencies = { "other/plugin" },
    -- Configuration function
    config = function()
      require("plugin").setup({
        -- options
      })
    end,
  },
}
```

### Utilities (`lua/utils/`)

**Purpose**: Helper functions for common tasks.

| File | Purpose |
|------|---------|
| `init.lua` | Utility functions (keymaps, commands, notifications, etc.) |

**Usage in your config:**

```lua
local utils = require("utils")
utils.map("n", "<leader>test", function()
  utils.info("Test message")
end)
```

## How to Add Your Configuration

### Adding a Keymap

**File**: `lua/core/keymaps.lua`

```lua
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Simple keymap
map("n", "<leader>test", ":echo 'Hello'<CR>", opts)

-- Keymap with Lua function
map("n", "<leader>test", function()
  vim.notify("Hello from Lua!")
end, opts)
```

### Adding a Global Option

**File**: `lua/core/options.lua`

```lua
local opt = vim.opt

opt.number = true           -- Enable line numbers
opt.tabstop = 2            -- Set tab width
opt.colorcolumn = "120"    -- Show column at position 120
```

### Adding an Autocommand

**File**: `lua/core/autocmds.lua`

```lua
local api = vim.api
local group = api.nvim_create_augroup("MyGroup", { clear = true })

api.nvim_create_autocmd("BufWritePost", {
  group = group,
  pattern = "*.lua",
  callback = function()
    vim.notify("Lua file saved!")
  end,
})
```

### Adding a Plugin

**File**: `lua/plugins/others.lua` (or create a new file in `lua/plugins/`)

```lua
return {
  {
    "plugin-owner/plugin-name",
    -- Lazy loading options
    event = "BufEnter",          -- Load on buffer enter
    -- or cmd = "PluginCommand",  -- Load on command
    -- or ft = "filetype",         -- Load on specific filetype
    
    -- Plugin dependencies
    dependencies = { "other/plugin" },
    
    -- Optional: specify version
    version = "*",
    
    -- Configuration
    config = function()
      require("plugin-name").setup({
        option = value,
      })
    end,
  },
}
```

### Adding a Language Server

**File**: `lua/plugins/lsp.lua`

```lua
lspconfig.your_server_name.setup({
  -- capabilities = capabilities,  -- Don't forget this!
  settings = {
    -- Server-specific settings
  },
})

-- Add to capabilities loop at the bottom
table.insert(servers, "your_server_name")
```

## Configuration Examples

### Change Color Scheme

**File**: `lua/plugins/ui.lua`

Find the `folke/tokyonight.nvim` section and change:
```lua
vim.cmd.colorscheme("tokyonight")  -- Change this
```

Or swap it for another colorscheme like:
```lua
vim.cmd.colorscheme("gruvbox")
```

### Enable Auto-format on Save

**File**: `lua/core/autocmds.lua`

Uncomment the auto-format section:
```lua
api.nvim_create_autocmd("BufWritePre", {
  group = group,
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
```

### Change Indentation

**File**: `lua/core/options.lua`

```lua
opt.tabstop = 2       -- Tab width
opt.shiftwidth = 2    -- Shift width
opt.expandtab = true  -- Use spaces instead of tabs
```

### Add Custom Command

**File**: `lua/core/keymaps.lua` or `lua/core/autocmds.lua`

```lua
vim.api.nvim_create_user_command("MyCommand", function()
  vim.notify("Custom command executed!")
end, {})
```

Then use:
```vim
:MyCommand
```

## Best Practices

### 1. Keep Modules Focused

Each file should have a single responsibility:
- `options.lua` → Only editor options
- `keymaps.lua` → Only keybindings
- `lsp.lua` → Only LSP servers
- `cmp.lua` → Only completion

### 2. Use vim.keymap.set for Keybindings

❌ **Old way (deprecated in 0.11):**
```lua
:lua require('telescope.builtin').find_files()
```

✅ **New way:**
```lua
map("n", "<leader>ff", function()
  require("telescope.builtin").find_files()
end, opts)
```

### 3. Lazy-Load Plugins

Always specify when a plugin should load:

```lua
{
  "plugin-name",
  event = { "BufReadPost", "BufNewFile" },  -- Load on buffer enter
  cmd = "CommandName",                       -- Load on command
  ft = "filetype",                           -- Load on specific file type
}
```

### 4. Group Related Settings

For options, group them logically:

```lua
-- ============================================================================
-- Display Options
-- ============================================================================

opt.number = true
opt.relativenumber = true
opt.cursorline = true
```

### 5. Use Meaningful Comments

```lua
-- Show whitespace characters (tab, trailing spaces, etc.)
opt.list = true
opt.listchars = {
  tab = "→ ",
  trail = "·",
}
```

## Troubleshooting Configuration

### Plugin not loading?

Check:
1. Is the plugin spec in `lua/plugins/`?
2. Is it being imported in `lua/plugins/init.lua`?
3. Does it have correct lazy-loading conditions (`event`, `cmd`, `ft`)?

### Keymap not working?

Check:
1. Is it in `lua/core/keymaps.lua`?
2. Is the mode correct (n, v, i, c)?
3. Are there conflicting keymaps?

**Debug:**
```vim
:map <leader>yourkey
```

### Option not being applied?

Check:
1. Is it in `lua/core/options.lua`?
2. Is `require("core.options")` called in `lua/core/init.lua`?
3. Reload config: `:so $MYVIMRC` or restart Neovim

## Performance Tips

### 1. Use Lazy Loading

```lua
-- ❌ Loads immediately
{ "plugin-name" }

-- ✅ Loads on demand
{ "plugin-name", event = "BufEnter" }
```

### 2. Use Proper Dependencies

```lua
-- ❌ Both load immediately
{ "plugin-a" },
{ "plugin-b" },

-- ✅ plugin-b only loads when plugin-a loads
{
  "plugin-a",
  dependencies = { "plugin-b" },
}
```

### 3. Check Startup Time

```vim
:StartupTime
```

## Neovim 0.11 Specific Notes

### Deprecated Features Avoided

✅ **This config avoids:**
- `:lua require(...)` in commands and mappings
- Deprecated LSP diagnostic functions
- Old nvim-lspconfig setup patterns

✅ **Modern approaches used:**
- `vim.keymap.set()` with Lua callbacks
- lazy.nvim for plugin management
- Modern LSP configuration

### Migration from Older Configs

If migrating from older Neovim:

1. Move all `:lua require(...)` commands to Lua `vim.keymap.set()` callbacks
2. Update LSP server configuration to use modern APIs
3. Use `lazy.nvim` instead of Packer or vim-plug
4. Run `:checkhealth vim.deprecated` to find any remaining issues

---

**Need help?** Check the main README.md for installation, keybindings, and troubleshooting.