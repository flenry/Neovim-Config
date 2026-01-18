# Neovim Configuration

A feature-rich Neovim configuration using lazy.nvim as the plugin manager, with LSP support, autocompletion, fuzzy finding, and more.

## Features

- **Plugin Manager**: [lazy.nvim](https://github.com/folke/lazy.nvim)
- **Color Theme**: Nord with transparent background support
- **File Explorer**: Neo-tree with git integration
- **Fuzzy Finder**: Telescope with fzf-native
- **LSP Support**: Mason-managed language servers
- **Autocompletion**: nvim-cmp with snippets
- **Formatting**: Auto-format on save via none-ls
- **Syntax Highlighting**: Treesitter
- **Git Integration**: Gitsigns, Fugitive, Rhubarb
- **Status Line**: Lualine
- **Buffer Line**: Bufferline with tabs
- **Dashboard**: Alpha-nvim start screen

### Language Support

| Language | LSP Server | Formatter/Linter |
|----------|------------|------------------|
| Lua | lua_ls | stylua |
| TypeScript/JavaScript | ts_ls | prettier, eslint_d |
| Python | pylsp, ruff | ruff |
| HTML | html | prettier |
| CSS | cssls | - |
| Tailwind CSS | tailwindcss | - |
| JSON | jsonls | prettier |
| YAML | yamlls | prettier |
| Docker | dockerls | - |
| SQL | sqlls | - |
| Terraform | terraformls | terraform_fmt |
| Java | jdtls | - |
| Shell | - | shfmt |
| Makefile | - | checkmake |

## Prerequisites

Before installing, ensure you have the following on your Mac:

### 1. Install Homebrew (if not already installed)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Install Neovim (0.10+)

```bash
brew install neovim
```

Verify the version:
```bash
nvim --version
```

### 3. Install Required Dependencies

```bash
# Required
brew install git
brew install ripgrep      # For Telescope live grep
brew install fd           # For faster file finding
brew install node         # For LSP servers and tools
brew install python3      # For Python LSP support
brew install make         # For telescope-fzf-native

# Optional but recommended
brew install lazygit      # Git TUI (if using git integrations)
```

### 4. Install a Nerd Font

Nerd Fonts are required for icons to display correctly:

```bash
# Install a Nerd Font (choose one)
brew install --cask font-jetbrains-mono-nerd-font
# or
brew install --cask font-fira-code-nerd-font
# or
brew install --cask font-hack-nerd-font
```

Then configure your terminal to use the installed Nerd Font.

## Installation

### 1. Backup Existing Config (if any)

```bash
# Backup existing nvim config
mv ~/.config/nvim ~/.config/nvim.bak

# Backup nvim data (optional)
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

### 2. Clone This Repository

```bash
git clone https://github.com/YOUR_USERNAME/nvim.git ~/.config/nvim
```

### 3. Start Neovim

```bash
nvim
```

On first launch:
1. **lazy.nvim** will automatically bootstrap and install all plugins
2. **Mason** will automatically install configured LSP servers and tools
3. Wait for all installations to complete (you can check with `:Lazy` and `:Mason`)

### 4. Verify Installation

Run these commands inside Neovim:
- `:Lazy` - Check plugin status
- `:Mason` - Check LSP/tool installation status
- `:checkhealth` - Verify Neovim health

## Key Bindings

Leader key: `<Space>`

### General

| Key | Action |
|-----|--------|
| `<C-s>` | Save file |
| `<C-q>` | Quit |
| `<leader>sn` | Save without auto-formatting |

### Navigation

| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Navigate between splits |
| `<C-d>` | Scroll down (centered) |
| `<C-u>` | Scroll up (centered) |
| `<Tab>` | Next buffer |
| `<S-Tab>` | Previous buffer |
| `<leader>x` | Close buffer |

### Windows

| Key | Action |
|-----|--------|
| `<leader>v` | Split vertically |
| `<leader>h` | Split horizontally |
| `<leader>se` | Equalize splits |
| `<leader>xs` | Close split |
| `<Up/Down/Left/Right>` | Resize splits |

### File Explorer (Neo-tree)

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file explorer |
| `\` | Reveal current file |
| `<leader>ngs` | Git status (floating) |

### Telescope (Fuzzy Finder)

| Key | Action |
|-----|--------|
| `<leader>sf` | Search files |
| `<leader>sg` | Search by grep (live) |
| `<leader>sw` | Search current word |
| `<leader>sh` | Search help |
| `<leader>sk` | Search keymaps |
| `<leader>sd` | Search diagnostics |
| `<leader>sr` | Resume last search |
| `<leader>s.` | Recent files |
| `<leader><leader>` | Find buffers |
| `<leader>/` | Fuzzy search in buffer |

### LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `gD` | Go to declaration |
| `<leader>D` | Type definition |
| `<leader>ds` | Document symbols |
| `<leader>ws` | Workspace symbols |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>th` | Toggle inlay hints |

### Diagnostics

| Key | Action |
|-----|--------|
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<leader>d` | Show diagnostic float |
| `<leader>q` | Diagnostic list |

### Misc

| Key | Action |
|-----|--------|
| `<leader>bg` | Toggle background transparency |
| `<leader>lw` | Toggle line wrap |

## Updating

### Update Plugins

Inside Neovim:
```vim
:Lazy update
```

### Update LSP Servers/Tools

Inside Neovim:
```vim
:Mason
```
Then press `U` to update all.

### Pull Latest Config

```bash
cd ~/.config/nvim
git pull
```

Then restart Neovim to apply changes.

## Troubleshooting

### Icons Not Displaying

- Ensure you have a Nerd Font installed
- Configure your terminal to use the Nerd Font
- Restart your terminal

### LSP Not Working

1. Check Mason: `:Mason` - ensure servers are installed
2. Check LSP status: `:LspInfo`
3. Check health: `:checkhealth lsp`

### Telescope Grep Not Working

Ensure ripgrep is installed:
```bash
brew install ripgrep
```

### Treesitter Errors

Update parsers:
```vim
:TSUpdate
```

### Clean Reinstall

If something breaks, you can do a clean reinstall:

```bash
# Remove nvim data
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

# Restart nvim - everything will reinstall
nvim
```

## File Structure

```
~/.config/nvim/
├── init.lua              # Entry point
├── lazy-lock.json        # Plugin version lock file
├── .stylua.toml          # Lua formatter config
└── lua/
    ├── core/
    │   ├── options.lua   # Vim options
    │   └── keymaps.lua   # Key mappings
    └── plugins/
        ├── alpha.lua         # Dashboard
        ├── autocompletion.lua
        ├── autoformatting.lua
        ├── bufferline.lua
        ├── colortheme.lua
        ├── gitsigns.lua
        ├── indent-blankline.lua
        ├── lsp.lua
        ├── lualine.lua
        ├── misc.lua
        ├── neotree.lua
        ├── opencode.lua
        ├── telescope.lua
        └── treesitter.lua
```

## License

MIT
