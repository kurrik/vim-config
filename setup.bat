#!/bin/bash

echo 'Copying files'
DIR="$( cd "$( dirname "$0" )" && pwd )"
rm -rf ~/vimfiles
rm ~/_vimrc

mkdir -p ~/vimfiles
cp -r $DIR/vim/* ~/vimfiles
cp $DIR/vimrc ~/_vimrc
