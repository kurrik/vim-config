#!/bin/bash

echo 'Creating symlinks'
DIR="$( cd "$( dirname "$0" )" && pwd )"
ln -s $DIR/vim ~/.vim
ln -s $DIR/vimrc ~/.vimrc

