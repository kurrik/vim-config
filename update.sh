#!/usr/bin/env bash
# update.sh: Update all plugins via lazy.nvim
NVIM="nvim"
if ! command -v nvim &> /dev/null; then
  echo "Neovim (nvim) not found. Please install Neovim to update plugins."
  exit 1
fi
$NVIM --headless "+Lazy! sync" +qa
