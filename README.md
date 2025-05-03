# Vim/Neovim Config

## Installation

1. Clone this repository:
   ```sh
   git clone <your-repo-url> ~/vim-config
   cd ~/vim-config
   ```
2. Run the setup script:
   ```sh
   ./setup.sh
   ```

## Theme Selection
- To change the theme, edit the `theme` variable in `nvim/init.lua` to either `catppuccin` or `gruvbox`.

## Keybindings
| Action                       | Keybinding      | Plugin         |
|------------------------------|-----------------|---------------|
| Toggle file browser          | `<leader>e`     | Neo-tree      |
| Fuzzy file search            | `<C-p>`         | Telescope     |
| Next buffer                  | `:bnext`        | cokeline      |
| Previous buffer              | `:bprev`        | cokeline      |
| Close buffer                 | `:bd`           | cokeline      |
| Horizontal split             | `:sp`           | Core          |
| Vertical split               | `:vsp`          | Core          |
| Move between splits          | `<C-w>h/j/k/l`  | Core          |
| Resize splits                | `<C-w><`, etc.  | Core          |
| Close split                  | `:q`            | Core          |

## Defaults
- Line numbers (absolute/relative)
- Two-space tabs
- LF line endings
- Mouse support
- Clipboard integration
- Spell check
- Smart case/incremental search
- Persistent undo
- Always show signcolumn
- Show matching parentheses
- Auto-read changed files
- Timeout for mappings
- No swap/backup files
- Scrolloff for context

## LSP Support
- TypeScript, Go, and Rust language servers are auto-installed/configured via mason.nvim.

## Maintenance
- To update plugins: `./update.sh`
- To uninstall/restore previous config: `./uninstall.sh`

## Troubleshooting
- Backups are stored in `.backup_*` directories in the repo root.
- If plugins do not load, ensure you are running Neovim >= 0.8 and have an internet connection for lazy.nvim bootstrap.

---

For more plugins or customization, edit or add files in `nvim/lua/config/`.
