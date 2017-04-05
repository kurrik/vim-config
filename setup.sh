#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

rm -rf ~/.vim
rm -rf ~/.vimrc

echo 'Creating symlinks'
ln -s $DIR/vim ~/.vim
ln -s $DIR/vimrc ~/.vimrc

echo 'Creating dirs'
mkdir -p ~/.vim/swp
mkdir -p ~/.vim/backup

