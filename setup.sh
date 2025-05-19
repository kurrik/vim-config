#!/usr/bin/env bash
# setup.sh: Backup and symlink Neovim/Vim config
set -e
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$REPO_DIR/.backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Backup and symlink Neovim config
echo "Setting up Neovim configuration..."
if [ -d "$HOME/.config/nvim" ] || [ -f "$HOME/.config/nvim/init.lua" ]; then
  echo "Backing up existing Neovim config..."
  mv "$HOME/.config/nvim" "$BACKUP_DIR/nvim_$(date +%s)" 2>/dev/null || true
fi
mkdir -p "$HOME/.config"
ln -sfn "$REPO_DIR/nvim" "$HOME/.config/nvim"

# Backup and symlink Vim config
echo "Setting up Vim configuration..."
if [ -f "$HOME/.vimrc" ]; then
  echo "Backing up existing .vimrc..."
  mv "$HOME/.vimrc" "$BACKUP_DIR/vimrc_$(date +%s)" || true
fi
ln -sf "$REPO_DIR/.vimrc" "$HOME/.vimrc"

# Create necessary directories for Vim
mkdir -p "$HOME/.vim/backup"
mkdir -p "$HOME/.vim/swap"
mkdir -p "$HOME/.vim/undo"

# Install vim-plug for Vim if not installed
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
  echo "Installing vim-plug for Vim..."
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo -e "\nSetup complete!"
echo "Backups stored in: $BACKUP_DIR"
echo "\nNext steps:"
echo "1. For Neovim: Launch nvim and run :Lazy install to install plugins"
echo "2. For Vim: Launch vim and run :PlugInstall to install plugins"
