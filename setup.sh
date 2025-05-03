#!/usr/bin/env bash
# setup.sh: Backup and symlink Neovim/Vim config
set -e
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$REPO_DIR/.backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Backup and symlink Neovim config
if [ -d "$HOME/.config/nvim" ] || [ -f "$HOME/.config/nvim/init.lua" ]; then
  mv "$HOME/.config/nvim" "$BACKUP_DIR/nvim_$(date +%s)" 2>/dev/null || true
fi
mkdir -p "$HOME/.config"
ln -sf "$REPO_DIR/nvim" "$HOME/.config/nvim"

# Backup and symlink Vim config
if [ -f "$HOME/.vimrc" ]; then
  mv "$HOME/.vimrc" "$BACKUP_DIR/vimrc_$(date +%s)" || true
fi
ln -sf "$REPO_DIR/nvim/init.lua" "$HOME/.vimrc"

if [ -d "$HOME/.vim" ]; then
  mv "$HOME/.vim" "$BACKUP_DIR/vim_$(date +%s)" || true
fi
ln -sf "$REPO_DIR/nvim" "$HOME/.vim"

echo "Backups stored in $BACKUP_DIR. Symlinks created for Neovim and Vim config."
