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

`setup.sh` is safe to re-run. It installs the required dependencies (`neovim`,
`fd`, `ripgrep`) automatically on macOS (via Homebrew) and Debian/Ubuntu (via
`apt`, which may prompt for `sudo`), then symlinks the config. On other
platforms it skips installation and prints what to install manually. A C
compiler and `make` are needed to build `telescope-fzf-native`; the script
warns if they're missing.

## Theme Selection
- To change the theme, edit the `theme` variable in `nvim/init.lua` to either `catppuccin` or `gruvbox`.

## Keybindings

The leader key is `Space`.

| Action                          | Keybinding      | Source            |
|---------------------------------|-----------------|-------------------|
| Toggle file browser             | `<leader>e`     | Neo-tree          |
| Reveal current file in browser  | `<leader>E`     | Neo-tree          |
| Fuzzy file search               | `<leader>p`     | Telescope         |
| Find in files (live grep)       | `<leader>f`     | Telescope         |
| Copy relative file path         | `<leader>y`     | Config            |
| Open Git interface (status)     | `<leader>g`     | Neogit            |
| Toggle split terminal           | `<leader>t`     | Config            |
| Open markdown preview           | `<leader>m`     | markdown-preview  |
| Exit terminal mode (to normal)  | `<Esc>`         | Config (Neovim)   |
| Next buffer                     | `<Tab>`         | cokeline          |
| Previous buffer                 | `<S-Tab>`       | cokeline          |
| Close buffer                    | `:bd`           | Vim built-in      |
| Horizontal split                | `:sp`           | Vim built-in      |
| Vertical split                  | `:vsp`          | Vim built-in      |
| Move between splits             | `<C-w>h/j/k/l`  | Vim built-in      |
| Resize splits                   | `<C-w><`, etc.  | Vim built-in      |
| Close split                     | `:q`            | Vim built-in      |

> In plain Vim, `<leader>t` opens a terminal (`:terminal`) and the terminal-mode
> `<Esc>` mapping is Neovim-only.

## Defaults
- Line numbers (absolute/relative)
- Two-space tabs
- LF line endings
- Mouse support
- Clipboard integration
- Spell check
- Smart case/incremental search
- Persistent undo

## Opening a Terminal in Neovim

Neovim includes a built-in terminal emulator. To open a terminal window within your Neovim session, use the command:

```
:terminal
```

This will open a terminal buffer where you can run shell commands directly. You can open multiple terminal buffers as needed. To return to normal mode from the terminal, press `<C-\><C-n>`.

Commands run inside the terminal that open an editor (e.g. `git commit`) do not
start a nested Neovim instance: flatten.nvim opens the file in the surrounding
instance instead, and the command resumes once you write and close that buffer
(`:wq`).

This only works when the command launches `nvim`, not plain `vim` — on macOS
git's default editor (`vi`) is real Vim, which flatten.nvim cannot intercept.
Make sure git uses Neovim: `git config --global core.editor nvim`.
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
- If plugins do not load, ensure you are running Neovim >= 0.11 (required by the LSP setup) and have an internet connection for lazy.nvim bootstrap.

---

For more plugins or customization, edit or add files in `nvim/lua/config/`.
