#!/usr/bin/env bash
# uninstall.sh: Restore previous Vim/Neovim configs from the latest backup
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
LATEST_BACKUP=$(ls -dt "$REPO_DIR"/.backup_* 2>/dev/null | head -1)
if [ -z "$LATEST_BACKUP" ]; then
  echo "No backup directory found. Cannot restore."
  exit 1
fi

# Restore Neovim config
echo "Restoring Neovim config..."
rm -rf "$HOME/.config/nvim"
if [ -d "$LATEST_BACKUP/nvim"* ]; then
  mv "$LATEST_BACKUP/nvim"* "$HOME/.config/nvim"
fi

# Restore Vim config
echo "Restoring Vim config..."
rm -rf "$HOME/.vim" "$HOME/.vimrc"
if [ -f "$LATEST_BACKUP/vimrc"* ]; then
  mv "$LATEST_BACKUP/vimrc"* "$HOME/.vimrc"
fi
if [ -d "$LATEST_BACKUP/vim"* ]; then
  mv "$LATEST_BACKUP/vim"* "$HOME/.vim"
fi

echo "Restoration complete."
