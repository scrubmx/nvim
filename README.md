# NeoVim

Personal [Neovim](https://neovim.io/) configuration written in Lua and managed
with [lazy.nvim](https://github.com/folke/lazy.nvim).

It provides language-server support, completion, formatting, linting,
Tree-sitter highlighting, fuzzy finding, Git integration, file navigation, and
optional AI-assisted completion.

<img width="1350" height="746" alt="Screenshot 2026-06-15 at 11 33 33 a m" src="https://github.com/user-attachments/assets/27bcdd99-e219-43e9-bc9d-6d0e86a9e038" />

<img width="1346" height="746" alt="Screenshot 2026-06-15 at 11 34 13 a m" src="https://github.com/user-attachments/assets/52bcdb8f-6530-4ae6-9dbf-64b49724f2d2" />

## Features

- Plugin management with `lazy.nvim`
- LSP server and developer-tool management with Mason
- Completion with `nvim-cmp`
- Formatting and diagnostics with `none-ls`
- Syntax highlighting, indentation, autotagging, and endwise support with
  Tree-sitter
- File and text search with Telescope
- File navigation with Neo-tree
- Git integration with Gitsigns and Fugitive
- Catppuccin and OneDark color schemes
- Neorg note-taking support
- Optional GitHub Copilot and Supermaven integration
- English and Spanish spell checking

The leader and local leader keys are both set to `,`.

## Requirements

### Required

- [Neovim](https://neovim.io) 0.11 or newer
- [Git](https://git-scm.com)
- `make` and a C compiler for native plugins and Tree-sitter parsers

### Recommended

- A [Nerd Font](https://www.nerdfonts.com) for icons
- [ripgrep](https://github.com/BurntSushi/ripgrep) for Telescope live grep
- [fd](https://github.com/sharkdp/fd) for faster file discovery
- [Node.js](https://nodejs.org) and npm for Node-based language servers and
  GitHub Copilot
- [LuaRocks](https://luarocks.org) for Neorg
- [tmux](https://github.com/tmux/tmux) for pane navigation
- A system clipboard provider appropriate for your operating system

## Installation

Back up an existing Neovim configuration before installing:

```sh
mv ~/.config/nvim ~/.config/nvim.backup
```

Clone this repository into Neovim's standard configuration directory:

```sh
git clone https://github.com/scrubmx/nvim.git ~/.config/nvim
```

Start Neovim:

```sh
nvim
```

On first launch, `lazy.nvim` is cloned automatically and installs the configured
plugins. Mason then installs the configured language servers, linters, and
formatters. Some tools may require their language runtime or package manager to
already be installed.

After installation, verify the setup:

```vim
:checkhealth
:Lazy
:Mason
```

## Machine-Specific Settings

Review these settings after cloning:

- `init.lua` contains a Homebrew-specific FZF runtime path.
- `lsp/intelephense.lua` contains a local Intelephense license-file path.
- `lua/plugins/neorg.lua` contains local Neorg workspace paths.
- AI completion plugins require separate authentication and may be disabled if
  they are not needed.

## Key Bindings

| Binding        | Action                                             |
| -------------- | -------------------------------------------------- |
| `,1`           | Toggle Neo-tree                                    |
| `,ff`          | Find files                                         |
| `,fa`          | Find all files, including hidden and ignored files |
| `,fg`          | Search text with live grep                         |
| `,fb`          | Open Telescope file browser                        |
| `,fo`          | List open buffers                                  |
| `,fd`          | List diagnostics                                   |
| `,fv`          | Search Neovim configuration files                  |
| `,bd`          | Delete the current buffer                          |
| `ss`           | Create a horizontal split                          |
| `sv`           | Create a vertical split                            |
| `Ctrl-h/j/k/l` | Navigate Vim splits and tmux panes                 |

Run `:Telescope keymaps` or open `,` and wait for WhichKey to discover more
bindings.

Arrow keys are intentionally disabled in normal and insert modes.

## Updating

Pull configuration changes and update plugins:

```sh
cd ~/.config/nvim
git pull
```

Then run:

```vim
:Lazy update
:MasonUpdate
:TSUpdate
```

## Structure

```text
.
├── init.lua             # Core editor options and entrypoint
├── lua/config/          # Autocommands, keymaps, and lazy.nvim setup
├── lua/plugins/         # Plugin specifications and configuration
├── lsp/                 # Native Neovim LSP server configurations
├── ftplugin/            # Filetype-specific settings
├── queries/             # Tree-sitter queries
├── snippets/            # Completion snippets
└── spell/               # Custom spell-checking dictionaries
```

## Troubleshooting

- Run `:checkhealth` to inspect Neovim and provider issues.
- Run `:Lazy log` to inspect plugin installation failures.
- Run `:MasonLog` to inspect language-server or tool installation failures.
- Run `:TSInstallInfo` to inspect Tree-sitter parsers.

## Author

Jorge González <scrub.mx@gmail.com>
