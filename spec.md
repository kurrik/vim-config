# Neovim/Vim Config Specification

## Overview
This project provides a modern, well-documented, and easily maintainable Neovim configuration (with compatibility for Vim). It is organized for clarity, ease of experimentation, and quick onboarding for new systems.

## Directory Structure
- `nvim/` — All Neovim/Vim config files (using Neovim conventions: `init.lua`, `lua/`, etc.)
- `README.md` — Installation instructions, keybindings, plugin usage, and troubleshooting
- `setup.sh` — Backs up existing configs, symlinks new config files
- `update.sh` — Updates all plugins
- `uninstall.sh` — Restores previous configs from backup
- `spec.md` — This specification

## Plugin Manager
- **lazy.nvim** (Neovim only)
  - All plugins managed through lazy.nvim
  - Vim loads shared config (settings), but skips plugins gracefully

## Plugins
- **Neo-tree.nvim** — File browser (toggle with `<leader>e`)
- **nvim-cokeline** — Bufferline/tabline
- **lualine.nvim** — Statusline
- **Telescope.nvim** — Fuzzy finder, “jump to file” (mapped to `<C-p>`)
- **mason.nvim** — Automatic LSP installer
- **Themes:**
  - Catppuccin
  - Original Gruvbox ([morhetz/gruvbox](https://github.com/morhetz/gruvbox))
  - Theme selection is controlled by a single config variable for easy swapping

## Editor Defaults
- Show absolute and relative line numbers
- Use two-space tabs
- Enforce LF line endings
- Enable mouse support
- Enable system clipboard integration
- Enable spell check
- Smart case search
- Incremental search
- Persistent undo
- Always show sign column
- Show matching parentheses
- Auto-read files changed outside of Neovim
- Set timeout for mapped sequences
- Disable swap/backup files
- Set scrolloff for context

## Language Server Protocol (LSP)
- Use mason.nvim to auto-install and configure LSPs for:
  - TypeScript
  - Go
  - Rust

## Keybindings
- **Neo-tree:** `<leader>e` to toggle file browser
- **Telescope:** `<C-p>` to jump to file (fuzzy finder)
- **Splits/Panes:**
  - Horizontal split: `:sp`
  - Vertical split: `:vsp`
  - Move: `<C-w>h/j/k/l`
  - Resize: `<C-w><`, `<C-w>>`, `<C-w>+`, `<C-w>-`
  - Close: `:q`
- **Buffers (cokeline):**
  - Next: `:bnext` (can be mapped)
  - Previous: `:bprev` (can be mapped)
  - Close: `:bd` (can be mapped)
- All custom and plugin keybindings documented in the README

## Setup & Maintenance Scripts
- **setup.sh:**
  - Backs up existing `~/.vimrc`, `~/.vim/`, and `~/.config/nvim/` (or `~/.nvim/`)
  - Symlinks new config files from repo
- **update.sh:**
  - Runs lazy.nvim’s update command to update all plugins
- **uninstall.sh:**
  - Restores original configs from backup

## Documentation
- All setup instructions, plugin usage, and keybindings described in `README.md`
- No in-editor help for now (can be added later if needed)

## Extensibility
- Themes and plugins can be added or swapped by editing a single config variable or section
- All config files are modular, well-documented, and organized for easy experimentation

---

This spec should be used as the reference for building and maintaining the repository.