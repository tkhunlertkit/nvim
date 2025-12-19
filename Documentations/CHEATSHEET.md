# Quick Reference Card

A quick reference for common commands and keybindings in this Neovim config.

## File Navigation

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search text) |
| `<leader>fb` | Find open buffers |
| `<leader>fh` | Find help tags |
| `<leader>fr` | Find recent files |
| `<leader>/` | Search in current buffer |
| `<leader>e` | Toggle file explorer (NvimTree) |

## Window & Buffer Management

| Key | Action |
|-----|--------|
| `<C-h>` | Move to left window |
| `<C-j>` | Move to bottom window |
| `<C-k>` | Move to top window |
| `<C-l>` | Move to right window |
| `<C-w>c` | Close current window |
| `<C-w>=` | Equalize window sizes |
| `gt` | Next tab |
| `gT` | Previous tab |

## Text Editing

| Key | Action |
|-----|--------|
| `<A-j>` | Move line down |
| `<A-k>` | Move line up |
| `<` / `>` | Indent left/right (visual mode) |
| `gcc` | Toggle line comment |
| `gbc` | Toggle block comment |
| `gc` | Toggle comment (visual mode) |
| `ys` | Surround text (with nvim-surround) |
| `cs` | Change surround |
| `ds` | Delete surround |

## LSP (Language Server)

| Key | Action |
|-----|--------|
| `K` | Show hover documentation |
| `gd` | Go to definition |
| `gi` | Go to implementation |
| `gr` | Go to references |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions |
| `<leader>d` | Show diagnostics in floating window |
| `[d` | Go to previous diagnostic |
| `]d` | Go to next diagnostic |
| `<leader>xw` | Toggle workspace diagnostics (Trouble) |
| `<leader>xd` | Toggle document diagnostics (Trouble) |

## Completion

| Key | Action |
|-----|--------|
| `<C-Space>` | Trigger completion |
| `<C-e>` | Abort completion |
| `<Tab>` | Select next item / expand snippet |
| `<S-Tab>` | Select previous item / jump snippet back |
| `<C-b>` | Scroll docs up |
| `<C-f>` | Scroll docs down |
| `<CR>` | Confirm selection |

## File Explorer (NvimTree)

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle NvimTree |
| `<CR>` | Open file/directory |
| `o` | Open file |
| `a` | Create new file |
| `d` | Delete |
| `r` | Rename |
| `c` | Copy |
| `x` | Cut |
| `p` | Paste |
| `y` | Copy name |
| `Y` | Copy full path |
| `g.` | Toggle hidden files |
| `R` | Refresh tree |

## Vim Commands (Command Mode)

| Command | Action |
|---------|--------|
| `:Telescope find_files` | Fuzzy find files |
| `:Telescope live_grep` | Grep in files |
| `:checkhealth` | Check health of Neovim/plugins |
| `:checkhealth vim.deprecated` | Check for deprecated features |
| `:Lazy` | Open lazy.nvim plugin manager |
| `:Lazy install` | Install missing plugins |
| `:Lazy update` | Update all plugins |
| `:Lazy sync` | Sync plugins (install, update, clean) |
| `:TSUpdate` | Update Treesitter parsers |
| `:TSInstall` | Install Treesitter parser |
| `:LspInfo` | Show active LSP servers |
| `:TroubleToggle` | Toggle Trouble diagnostics |
| `:UndotreeToggle` | Toggle undo tree |
| `:MarkdownPreview` | Preview markdown in browser |
| `:Oil` | Open file browser as buffer |
| `:TodoTelescope` | Find TODO/FIXME comments |

## Telescope Commands

Inside Telescope picker:

| Key | Action |
|-----|--------|
| `<C-n>` | History next |
| `<C-p>` | History previous |
| `<C-j>` | Move selection down |
| `<C-k>` | Move selection up |
| `<CR>` | Open selection |
| `<C-x>` | Open in horizontal split |
| `<C-v>` | Open in vertical split |
| `<C-t>` | Open in new tab |
| `<C-c>` | Close Telescope |

## Comments

| Key | Action |
|-----|--------|
| `gcc` | Toggle line comment |
| `gbc` | Toggle block comment |
| `gcO` | Insert comment above |
| `gco` | Insert comment below |
| `gcA` | Insert comment at end of line |

## Surround (nvim-surround)

| Key | Action |
|-----|--------|
| `ys` + motion + char | Add surround (normal mode) |
| `yss` + char | Surround entire line |
| `S` + char | Surround selection (visual mode) |
| `cs` + old + new | Change surround |
| `ds` + char | Delete surround |
| `>` / `<` | Add angle brackets |
| `[` / `]` | Add square brackets |
| `{` / `}` | Add curly braces |
| `(` / `)` | Add parentheses |
| `'` / `"` / `` ` `` | Add quotes |

## Git Integration (Gitsigns)

| Key | Action |
|-----|--------|
| `]c` | Next git change |
| `[c` | Previous git change |
| `<leader>hs` | Stage hunk |
| `<leader>hu` | Undo stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage buffer |
| `<leader>hU` | Undo stage buffer |
| `<leader>hR` | Reset buffer |
| `<leader>hp` | Preview hunk |

## General Editor

| Command | Action |
|---------|--------|
| `:w` | Save file |
| `:q` | Quit |
| `:wq` | Save and quit |
| `:qa` | Quit all |
| `u` | Undo |
| `<C-r>` | Redo |
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n` | Next search result |
| `N` | Previous search result |
| `*` | Search word under cursor |
| `#` | Search word backward |
| `:s/old/new` | Replace in line |
| `:%s/old/new/g` | Replace in file |

## Advanced Navigation

| Key | Action |
|-----|--------|
| `w` | Next word |
| `b` | Previous word |
| `e` | End of word |
| `(` | Previous sentence |
| `)` | Next sentence |
| `{` | Previous paragraph |
| `}` | Next paragraph |
| `gg` | Go to start of file |
| `G` | Go to end of file |
| `:nG` | Go to line n |
| `%` | Jump to matching bracket |

## Marks

| Command | Action |
|---------|--------|
| `m` + char | Set mark |
| `` ` `` + char | Jump to mark |
| `:marks` | List all marks |
| `:delmarks` | Delete marks |

## Macros

| Key | Action |
|-----|--------|
| `q` + char | Start recording macro |
| `q` | Stop recording |
| `@` + char | Play macro |
| `@@` | Repeat last macro |

## Tips & Tricks

### Search and Replace
```vim
:%s/old/new/g         " Replace all in file
:s/old/new/g          " Replace in line
:%s/old/new/gc        " Replace with confirmation
```

### Multiple Cursors
Use `<C-d>` to select multiple instances (from `vim-visual-multi`)

### Code Folding
| Command | Action |
|---------|--------|
| `zR` | Open all folds |
| `zM` | Close all folds |
| `za` | Toggle fold |
| `zc` | Close fold |
| `zo` | Open fold |
| `zj` | Go to next fold |
| `zk` | Go to previous fold |

### Text Objects
| Object | Description |
|--------|-------------|
| `w` | Word |
| `s` | Sentence |
| `p` | Paragraph |
| `"` | Quoted string |
| `{` / `}` | Braces block |
| `[` / `]` | Brackets block |
| `<` / `>` | Angle brackets block |
| `t` | HTML/XML tag |

Use with operators: `daw` (delete word), `cis` (change in sentence)

## Custom Local Shortcuts

You can add custom keymaps by editing `lua/core/keymaps.lua`:

```lua
map("n", "<leader>mykey", function()
  -- Your action here
end, opts)
```

---

**Last Updated**: December 19, 2025
**Neovim Version**: 0.11.5+