#!/usr/bin/env zsh

ROOT=$(git rev-parse --show-toplevel)
TS=$(date "+%s")
CONFIG_ROOT=${XDG_CONFIG_HOME:-$HOME/.config}

function backup {
	FILE=$1
	BACKUP=$1.backup-$TS
	if [[ -a $FILE ]]; then
		echo "Backing up $FILE to $BACKUP"
		mv $FILE $BACKUP
	else
		echo "Could not find $FILE, skipping..."
	fi
}

function link {
	SRC=$1
	DST=$2
	echo "Linking $SRC to $DST"
	ln -s $SRC $DST
}

mkdir -p $CONFIG_ROOT

backup ~/.vim
backup ~/.vimrc
backup $CONFIG_ROOT/nvim

echo 'Creating symlinks'
link $ROOT/nvim ~/.vim
link $ROOT/nvim/init.vim ~/.vimrc
link $ROOT/nvim $CONFIG_ROOT/nvim

echo 'Creating dirs'
mkdir -p ~/.tmp/nvim/swp
mkdir -p ~/.tmp/nvim/backup
