# Modern Neovim Configuration Installation Guide

This repository contains a modular, modern Lua configuration for Neovim, utilizing `vim.*` APIs instead of the traditional `require` calls. It is designed to be clean, maintainable, and easy to debug.

## 📋 Prerequisites

Before installing, ensure you have the following:

- **Neovim >= 0.9.0** (Required for modern API support)
- **Nerd Font** (Optional, but recommended for icons)
- **Plugin Manager** (e.g., [lazy.nvim](https://github.com/folke/lazy.nvim) or [packer.nvim](https://github.com/wbthomason/packer.nvim))
  > **Note**: This configuration assumes you have the following plugins installed via your plugin manager:
  > - `williamboman/mason.nvim`
  > - `williamboman/mason-lspconfig.nvim`
  > - `neovim/nvim-lspconfig`
  > - `lukas-reineke/lsp-format.nvim`

## 📂 Repository Structure

The configuration is organized into a modular structure where every file has a single responsibility.

```text
nvim/
├── init.lua                  # 🚀 Main entry point (minimal)
└── lua/
    ├── config/
    │   ├── init.lua          # ⚙️  Master loader (handles loading order)
    │   ├── diagnostics.lua   # 🔍 Diagnostic display configuration
    │   ├── keymaps.lua       # ⌨️  LSP and global keybindings
    │   ├── lspconfig.lua     # 🧠 Language server configurations (Pyright, Lua, etc.)
    │   └── mason.lua         # 📦 Mason package manager setup
    └── utils/
        └── helpers.lua       # 🛠️  Utility functions for debugging & notifications
```

---

## 🚀 Installation Procedure

Follow these steps to install this configuration on your machine.

### Step 1: Backup Your Existing Configuration
**Critical Step:** If you have an existing Neovim configuration, move it to a backup location to prevent conflicts or data loss.

```bash
# Linux / macOS
mv ~/.config/nvim ~/.config/nvim.backup

# Windows (PowerShell)
Rename-Item -Path $env:LOCALAPPDATA\nvim -NewName nvim.backup
```

### Step 2: Clone the Repository
Clone this repository directly into your Neovim configuration directory.

```bash
# Linux / macOS
git clone https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git ~/.config/nvim

# Windows (PowerShell)
git clone https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git $env:LOCALAPPDATA\nvim
```

### Step 3: Install Plugins
Open Neovim. You may see errors initially because plugins are not yet installed. This is normal.

1. Open Neovim:
   ```bash
   nvim
   ```
2. Run your plugin manager's install command.
   - For **Lazy.nvim**: `:Lazy sync`
   - For **Packer**: `:PackerSync`

### Step 4: Configure Local Paths (Important!)
The configuration includes a logging path for the EFM language server that needs to match your system.

1. Open the LSP configuration file:
   ```bash
   nvim lua/config/lspconfig.lua
   ```
2. Find the line defining the log file path (around line ~90):
   ```lua
   -- Find this line:
   logFile = "/home/tkhunlertkit/efmlog.txt",

   -- Change it to your own home directory path:
   logFile = "/home/YOUR_USERNAME/efmlog.txt",
   ```
3. Save and quit (`:wq`).

### Step 5: Verify Installation
Restart Neovim and run the verification command to ensure everything loaded correctly.

```vim
:messages
```

You should see a clean startup log similar to:
```text
🔧 Initializing Neovim configuration...
✓ Diagnostics configured
✓ Mason configured
✓ LSP configured
✓ Keymaps configured
✅ Configuration loaded successfully!
```

---

## 📖 Module Descriptions

Here is a detailed breakdown of what each file in this package does.

### 1. `init.lua`
The simplified entry point. It strictly handles adding the Lua directory to the runtime path and requiring the main config loader.
```lua
-- Only essential loading logic
vim.opt.runtimepath:append(vim.fn.stdpath("config") .. "/lua")
require("config.init")
```

### 2. `lua/config/init.lua`
The **Master Loader**. It replaces the old "require everything at top level" approach.
- **Function**: Defines a `safe_require` utility to prevent Neovim from crashing if a module fails.
- **Order**: Enforces a strict loading sequence (Diagnostics -> Mason -> LSP -> Keymaps).
- **Feedback**: Uses `vim.notify` to provide visual startup status.

### 3. `lua/config/mason.lua`
Handles the **Mason** package manager integration.
- Configures the UI icons (✓, ➜, ✗).
- Sets up `mason-lspconfig` to automatically install servers (`pyright`, `ts_ls`, `lua_ls`, `efm`) if they are missing.
- **Customization**: Add new servers to the `ensure_installed` table here.

### 4. `lua/config/lspconfig.lua`
The core **Language Server Protocol** configuration.
- **Servers**: specific setup for Python (Pyright), JS/TS (ts_ls), and Lua.
- **EFM Integration**: Configures external formatters like `black`, `isort`, and `prettier`.
- **Capabilities**: Enables modern completion capabilities for `cmp` (if used).

### 5. `lua/config/keymaps.lua`
Centralized **Keybindings**.
- **Global**: Diagnostics navigation (`[d`, `]d`, `<leader>e`).
- **LSP-Specific**: Uses an `LspAttach` autocommand to only create keymaps (like `gd`, `gr`, `K`) when a language server actually connects to the buffer.
- **Docs**: Includes comments explaining every keymap.

### 6. `lua/config/diagnostics.lua`
Visual settings for **Errors and Warnings**.
- Configures virtual text (the error text next to code).
- Defines custom signs (Error = ❌, Warn = ⚠️).
- Sets update behavior (e.g., don't update while typing in insert mode).

---

## 🛠️ Troubleshooting

**Issue: "Module 'mason' not found"**
- **Cause**: You haven't installed the plugins yet.
- **Fix**: Run your plugin manager's install command (`:Lazy install` or `:PackerInstall`).

**Issue: Formatting (`<leader>f`) doesn't work**
- **Cause**: The external formatter (e.g., `black` for Python) isn't installed on your system.
- **Fix**: Install the tool manually or via Mason.
  ```vim
  :MasonInstall black prettier
  ```

**Issue: LSP Errors in `lspconfig.lua`**
- **Cause**: You likely forgot to update the `efmlog.txt` path in Step 4.
- **Fix**: Edit `lua/config/lspconfig.lua` and set a valid path.
