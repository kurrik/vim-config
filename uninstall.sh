#!/usr/bin/env/bash
# uninstall.sh: Restore previous Vim/Neovim configs from the latest backup
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
LATEST_BACKUP=$(ls -dt "$REPO_DIR"/.backup_* 2>/dev/null | head -1)

if [ -z "$LATEST_BACKUP" ]; then
  echo "No backup directory found. Cannot restore."
  exit 1
fi

# Restore Neovim config
echo "Restoring Neovim configuration..."
if [ -d "$LATEST_BACKUP/nvim"* ]; then
  rm -rf "$HOME/.config/nvim"
  mv "$LATEST_BACKUP/nvim"* "$HOME/.config/nvim"
  echo "✓ Restored Neovim config"
else
  echo "ℹ No Neovim backup found, removing symlinks..."
  [ -L "$HOME/.config/nvim" ] && rm -f "$HOME/.config/nvim"
fi

# Restore Vim config
echo -e "\nRestoring Vim configuration..."
if [ -f "$LATEST_BACKUP/vimrc"* ]; then
  rm -f "$HOME/.vimrc"
  mv "$LATEST_BACKUP/vimrc"* "$HOME/.vimrc"
  echo "✓ Restored .vimrc"
else
  echo "ℹ No .vimrc backup found, removing symlink..."
  [ -L "$HOME/.vimrc" ] && rm -f "$HOME/.vimrc"
fi

# Clean up Vim directories (only if they're not symlinks)
if [ -d "$HOME/.vim" ] && [ ! -L "$HOME/.vim" ]; then
  echo -e "\nBacking up existing Vim directory..."
  mv "$HOME/.vim" "$LATEST_BACKUP/vim_$(date +%s)"
  echo "✓ Backed up existing Vim directory"
fi

# Remove any remaining symlinks
[ -L "$HOME/.vim" ] && rm -f "$HOME/.vim"

# Remove empty backup directory if it exists
if [ -d "$BACKUP_DIR" ] && [ -z "$(ls -A "$BACKUP_DIR" 2>/dev/null)" ]; then
  rmdir "$BACKUP_DIR"
fi

echo -e "\nRestoration complete!"
echo "Backups are preserved in: $LATEST_BACKUP"
echo "You may want to manually remove this directory if you don't need the backups anymore."
