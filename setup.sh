#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

echo 'Creating dirs'
mkdir -p ~/.vim/swp
mkdir -p ~/.vim/backup

echo 'Creating symlinks'
ln -s $DIR/vim ~/.vim
ln -s $DIR/vimrc ~/.vimrc
