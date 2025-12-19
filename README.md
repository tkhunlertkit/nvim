# nvim-config

Modern Neovim configuration for **Neovim v0.11.5+**, built with Lua and best practices. No deprecated `:lua require(...)` in mappings or commands. All configuration uses Lua modules, `vim.keymap.set` callbacks, and lazy.nvim for efficient plugin management.

## Features

✨ **Core Features:**
- Lua-based configuration with `init.lua` and structured `lua/` directory
- **lazy.nvim** for fast startup and lazy-loading plugins
- Modern keymaps using `vim.keymap.set` with Lua callbacks (Neovim 0.11.5 compatible)
- LSP (Language Server Protocol) configuration for multiple languages
- Treesitter for syntax highlighting, indentation, and text objects
- nvim-cmp for smart autocompletion with snippets
- Telescope for fuzzy finding files, text, and more
- NvimTree for file exploration
- Multiple LSP servers configured (Lua, Python, TypeScript, Go, Rust, and more)

📦 **Plugin Highlights:**
- **LSP**: nvim-lspconfig with 10+ language servers pre-configured
- **Completion**: nvim-cmp with LuaSnip snippets and LSP integration
- **UI**: Tokyo Night colorscheme, lualine statusline, bufferline, indent guides, noice
- **Editor**: Comment.nvim, nvim-surround, Auto-pairs, which-key
- **Git**: Gitsigns, vim-fugitive, vim-rhubarb
- **Fuzzy Finder**: Telescope with fzf-native, ui-select, and live-grep-args
- **Quality of Life**: Trouble diagnostics, Todo-comments, Gitsigns, Undotree, Dashboard

## Directory Structure

```
~/.config/nvim
├── init.lua
├── lua
│   ├── core
│   │   ├── init.lua
│   │   ├── options.lua        # Global settings (indentation, display, etc.)
│   │   ├── keymaps.lua        # Keybindings (using vim.keymap.set)
│   │   └── autocmds.lua       # Autocommands
│   ├── plugins
│   │   ├── init.lua           # lazy.nvim bootstrap and plugin specs
│   │   ├── lsp.lua            # LSP configuration
│   │   ├── cmp.lua            # Completion (nvim-cmp)
│   │   ├── treesitter.lua     # Treesitter setup
│   │   ├── telescope.lua      # Fuzzy finder
│   │   ├── ui.lua             # UI plugins (colorscheme, statusline, etc.)
│   │   ├── editor.lua         # Editor enhancements (file explorer, comments, etc.)
│   │   └── others.lua         # Additional plugins
│   └── utils
│       └── init.lua           # Helper functions (optional)
└── README.md

```

## Prerequisites

Before installing this config, ensure you have the following installed:

### Required:
- **Neovim v0.11.5 or newer**
  - Install from your package manager (apt, brew, pacman, etc.) or build from source
  - Verify: `nvim --version`
- **Git** (for cloning this repo and lazy.nvim bootstrap)
- **Build tools** (for compiling Treesitter parsers and some plugins):
  - Linux: `build-essential` (Debian/Ubuntu) or `base-devel` (Arch)
  - macOS: Xcode Command Line Tools (`xcode-select --install`)
  - Windows: MSVC or MinGW

### Strongly Recommended:
- **Node.js 16+** (for TypeScript/JavaScript LSP and some plugins)
  - Install via nvm, fnm, or your package manager
- **Python 3** with pip
  - Install pynvim: `pip install --user pynvim`
- **Compiler for your languages** (gcc, clang, etc.)

### Optional but Useful:
- **ripgrep** (`rg`) - for Telescope live grep performance
- **fd** - for faster file finding in Telescope
- **Language-specific tools**:
  - **Python**: pyright or pylsp
  - **Go**: gopls
  - **Rust**: rust-analyzer
  - **TypeScript/JavaScript**: typescript-language-server, typescript
  - **Lua**: lua-language-server
  - **Bash**: bash-language-server

## Installation

### Step 1: Backup/Remove Existing Config

If you have an existing Neovim config, back it up first:

```bash
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null || true
mv ~/.local/share/nvim ~/.local/share/nvim.bak 2>/dev/null || true
mv ~/.cache/nvim ~/.cache/nvim.bak 2>/dev/null || true
```

### Step 2: Clone This Repository

```bash
git clone https://github.com/<your-username>/nvim-config.git ~/.config/nvim
```

Replace `<your-username>` with your GitHub username or organization.

### Step 3: Install System Dependencies

#### Linux (Ubuntu/Debian):
```bash
sudo apt update
sudo apt install -y git curl build-essential nodejs npm python3 python3-pip ripgrep fd-find
pip install --user pynvim
```

#### Linux (Arch):
```bash
sudo pacman -S base-devel git curl nodejs npm python python-pip ripgrep fd
pip install --user pynvim
```

#### macOS:
```bash
# Install Homebrew if needed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install neovim git node python ripgrep fd
pip3 install --user pynvim
```

#### Windows (with Scoop or Chocolatey):

**Using Scoop:**
```powershell
scoop install neovim git nodejs python ripgrep fd
pip install --user pynvim
```

**Using Chocolatey:**
```powershell
choco install neovim git nodejs python ripgrep fd
pip install --user pynvim
```

### Step 4: Install Language Servers (Optional but Recommended)

Choose which language servers to install based on your needs:

```bash
# Lua
sudo npm install -g lua-language-server

# Python (Pyright)
pip install --user pyright

# TypeScript/JavaScript
sudo npm install -g typescript-language-server typescript

# Go
go install github.com/golang/tools/gopls@latest

# Rust (if you have Rust installed)
rustup component add rust-analyzer

# Bash
sudo npm install -g bash-language-server

# JSON/YAML - already configured with nvim-lspconfig
```

### Step 5: First Neovim Start

Open Neovim:

```bash
nvim
```

**On first startup:**
1. lazy.nvim will automatically clone itself into `~/.local/share/nvim/lazy/lazy.nvim`
2. Plugin specs from `lua/plugins/` will be loaded
3. Plugins will be installed automatically
4. Wait for the installation to complete (you'll see a dashboard or installer UI)
5. Exit and restart Neovim

```bash
:q
nvim
```

### Step 6: Verify Everything Works

Inside Neovim, run:

```vim
:checkhealth
:checkhealth vim.deprecated
```

Fix any reported issues:
- Missing executables: Install the required tools
- LSP not found: Install the corresponding language server
- Treesitter parser missing: Run `:TSUpdate` to install them

Install Treesitter parsers:

```vim
:TSUpdate
```

## Common Keybindings

### General Navigation
| Key | Action |
|-----|--------|
| `<C-h>` | Window left |
| `<C-j>` | Window down |
| `<C-k>` | Window up |
| `<C-l>` | Window right |
| `<A-j>` / `<A-k>` | Move line up/down |
| `<` / `>` (visual) | Indent left/right |

### Leader Key Mappings (Space)
| Key | Action |
|-----|--------|
| `<leader>w` | Save file |
| `<leader>q` | Quit |
| `<leader>Q` | Quit all |
| `<leader>nh` | Clear search highlights |
| `<leader>e` | Toggle file explorer (NvimTree) |

### Telescope (Fuzzy Finder)
| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search text) |
| `<leader>fb` | Find buffers |
| `<leader>fh` | Find help tags |
| `<leader>fr` | Find recent files |
| `<leader>/` | Search current buffer |

### LSP Keybindings
| Key | Action |
|-----|--------|
| `K` | Hover documentation |
| `gd` | Go to definition |
| `gi` | Go to implementation |
| `gr` | Go to references |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions |
| `<leader>d` | Show diagnostics |
| `[d` / `]d` | Navigate diagnostics |

### Comments
| Key | Action |
|-----|--------|
| `gcc` | Toggle line comment |
| `gbc` | Toggle block comment |
| `gc` (visual) | Toggle comment on selection |

### Editor
| Key | Action |
|-----|--------|
| `<leader>xx` | Toggle Trouble (diagnostics) |
| `<leader>u` | Toggle Undotree |
| `ys` | Surround (with nvim-surround) |

## Customization

### Add/Remove Plugins
Edit the corresponding file in `lua/plugins/` or `lua/plugins/init.lua`:

```lua
-- In lua/plugins/others.lua
return {
  {
    "plugin-name/plugin",
    event = "BufEnter",
    config = function()
      require("plugin").setup({
        -- your config
      })
    end,
  },
}
```

### Modify Keybindings
Edit `lua/core/keymaps.lua`:

```lua
map("n", "<leader>custom", function()
  vim.notify("Custom keymap!")
end, opts)
```

### Change Settings
Edit `lua/core/options.lua`:

```lua
opt.number = true
opt.tabstop = 2  -- Change tab width
```

### Add Language Servers
Edit `lua/plugins/lsp.lua` and add a new server:

```lua
lspconfig.your_server.setup({
  settings = {
    -- server-specific settings
  },
})
```

## Updating

Pull the latest changes:

```bash
cd ~/.config/nvim
git pull
nvim
```

Then update plugins:

```vim
:Lazy sync
```

## Troubleshooting

### Plugins not loading
```vim
:Lazy
" Check if plugins are properly installed
" Use 'i' in the Lazy UI to install missing plugins
```

### Missing language server
```vim
:LspInfo
" Shows which LSP servers are available/running
" Install the language server manually if missing
```

### Treesitter parser issues
```vim
:TSUpdate
:checkhealth nvim-treesitter
```

### Check for deprecated APIs
```vim
:checkhealth vim.deprecated
" Fix any warnings reported
```

### Clear cache and reinstall
```bash
rm -rf ~/.local/share/nvim/lazy
rm -rf ~/.cache/nvim
nvim
" lazy.nvim will reinstall all plugins on next start
```

## Neovim 0.11 Migration Notes

This config avoids deprecated patterns from older Neovim versions:

✅ **What changed:**
- All user commands and keymaps use `vim.keymap.set()` with Lua callbacks (not `:lua require()`)
- LSP configuration uses modern nvim-lspconfig patterns
- No use of deprecated diagnostic functions or sign_define patterns
- All plugins are configured through their Lua modules

✅ **Best practices applied:**
- Plugin specs in `lua/plugins/` with proper `event`, `cmd`, `ft` lazy-loading
- LSP capabilities properly merged with cmp_nvim_lsp
- Snippet integration with LuaSnip
- Proper use of keymaps with buffer-local options where needed

## License

This configuration is provided as-is. Feel free to modify and distribute as you wish.

## Credits

- **Neovim**: https://neovim.io
- **lazy.nvim**: https://github.com/folke/lazy.nvim
- **nvim-lspconfig**: https://github.com/neovim/nvim-lspconfig
- **All plugin authors** listed in the plugin specifications

## Contributing

Feel free to fork, modify, and improve this configuration. If you find issues or have suggestions, consider opening an issue or PR in your fork.

---

**Last updated**: December 19, 2025
**Neovim version**: 0.11.5+
**Lua version**: 5.1+