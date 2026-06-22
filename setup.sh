#!/usr/bin/env bash
# setup.sh: Install dependencies and symlink Neovim/Vim config.
# Safe to re-run: only installs what's missing and only backs up real files.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
MIN_NVIM="0.11"   # this config's LSP setup uses vim.lsp.config (nvim 0.11+)

# Backup dir is created lazily, only when something actually needs backing up.
BACKUP_DIR=""
MADE_BACKUP=0
APT_UPDATED=0

# --- helpers ----------------------------------------------------------------

have() { command -v "$1" >/dev/null 2>&1; }
warn() { echo "⚠ $*" >&2; }

detect_os() {
  case "$(uname -s)" in
    Darwin) echo macos ;;
    Linux)  echo linux ;;
    *)      echo unknown ;;
  esac
}

# version_ge A B -> prints "y" if A >= B (comparing major.minor), else "n".
version_ge() {
  awk -v a="$1" -v b="$2" 'BEGIN {
    split(a, x, "."); split(b, y, ".");
    for (i = 1; i <= 2; i++) {
      xi = x[i] + 0; yi = y[i] + 0;
      if (xi > yi) { print "y"; exit }
      if (xi < yi) { print "n"; exit }
    }
    print "y"
  }'
}

apt_update_once() {
  if [ "$APT_UPDATED" -eq 0 ]; then
    sudo apt-get update -y
    APT_UPDATED=1
  fi
}

# pkg_install <brew_pkg> <apt_pkg>
pkg_install() {
  case "$OS" in
    macos) brew install "$1" ;;
    linux) apt_update_once; sudo apt-get install -y "$2" ;;
  esac
}

ensure_backup_dir() {
  if [ -z "$BACKUP_DIR" ]; then
    BACKUP_DIR="$REPO_DIR/.backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$BACKUP_DIR"
  fi
}

# link_config <source-in-repo> <destination-in-home>
link_config() {
  local src=$1 dest=$2
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "✓ $dest already linked"
    return
  fi
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    ensure_backup_dir
    echo "Backing up existing $dest..."
    mv "$dest" "$BACKUP_DIR/$(basename "$dest")_$(date +%s)"
    MADE_BACKUP=1
  fi
  mkdir -p "$(dirname "$dest")"
  ln -s "$src" "$dest"
  echo "✓ Linked $dest -> $src"
}

# --- dependency installation ------------------------------------------------

install_dependencies() {
  echo "Checking dependencies..."

  if [ "$OS" = "unknown" ]; then
    warn "Unsupported OS ($(uname -s)). Install 'neovim', 'fd', and 'ripgrep' manually, then re-run."
    return
  fi
  if [ "$OS" = "macos" ] && ! have brew; then
    warn "Homebrew not found. Install it from https://brew.sh, then re-run this script."
    exit 1
  fi
  if [ "$OS" = "linux" ] && ! have apt-get; then
    warn "apt-get not found (only apt-based distros are auto-supported)."
    warn "Install 'neovim', 'fd-find', and 'ripgrep' with your package manager, then re-run."
    return
  fi

  if have nvim; then
    echo "✓ Neovim already installed"
  else
    echo "Installing Neovim..."
    pkg_install neovim neovim
  fi

  # On Debian/Ubuntu fd ships its binary as 'fdfind' (telescope detects both).
  if have fd || have fdfind; then
    echo "✓ fd already installed"
  else
    echo "Installing fd..."
    pkg_install fd fd-find
  fi

  if have rg; then
    echo "✓ ripgrep already installed"
  else
    echo "Installing ripgrep..."
    pkg_install ripgrep ripgrep
  fi
}

check_nvim_version() {
  have nvim || return 0
  local v
  v=$(nvim --version | head -1 | sed -E 's/^NVIM v?([0-9]+\.[0-9]+).*/\1/')
  if [ "$(version_ge "$v" "$MIN_NVIM")" != "y" ]; then
    warn "Neovim $v is older than $MIN_NVIM. This config's LSP setup (vim.lsp.config)"
    warn "  requires Neovim $MIN_NVIM+. Consider upgrading (e.g. via a newer apt repo,"
    warn "  the official AppImage, or Homebrew)."
  fi
}

# Tools this config needs but that we don't auto-install (out of scope): warn only.
soft_check() {
  have git  || warn "git not found — lazy.nvim needs it to clone plugins."
  have curl || warn "curl not found — needed to install vim-plug for Vim."
  if ! have make || ! have cc; then
    warn "make/C compiler not found — telescope-fzf-native cannot build."
    case "$OS" in
      macos) warn "  Fix: xcode-select --install" ;;
      linux) warn "  Fix: sudo apt-get install build-essential" ;;
    esac
  fi
}

# --- config linking ---------------------------------------------------------

install_vim_plug() {
  local plug="$HOME/.vim/autoload/plug.vim"
  if [ -f "$plug" ]; then
    echo "✓ vim-plug already installed"
  elif have curl; then
    echo "Installing vim-plug for Vim..."
    curl -fLo "$plug" --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  else
    warn "curl not found — skipping vim-plug install."
  fi
}

# --- main -------------------------------------------------------------------

OS="$(detect_os)"

install_dependencies
check_nvim_version
soft_check

echo ""
echo "Setting up configuration..."
link_config "$REPO_DIR/nvim"  "$HOME/.config/nvim"
link_config "$REPO_DIR/.vimrc" "$HOME/.vimrc"

mkdir -p "$HOME/.vim/backup" "$HOME/.vim/swap" "$HOME/.vim/undo"
install_vim_plug

echo ""
echo "Setup complete!"
if [ "$MADE_BACKUP" -eq 1 ]; then
  echo "Backups stored in: $BACKUP_DIR"
fi
echo ""
echo "Next steps:"
echo "1. Neovim: launch nvim — lazy.nvim auto-installs plugins on first start."
echo "2. Vim: launch vim and run :PlugInstall."
