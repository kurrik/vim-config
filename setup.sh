echo 'Creating symlinks'
DIR="$( cd "$( dirname "$0" )" && pwd )"
cd ~; ln -s $DIR/vim .vim
cd ~; ln -s $DIR/vimrc .vimrc

