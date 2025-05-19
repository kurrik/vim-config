" Vim configuration
" Load shared settings
source ~/workspace/vim-config/shared/basic.vim

" Vim-specific settings
set nocompatible

" Load plugins using vim-plug (uncomment and modify as needed)
" call plug#begin('~/.vim/plugged')
" Plug 'morhetz/gruvbox'
" call plug#end()

" Theme settings (example using gruvbox)
" set background=light
" colorscheme gruvbox

" Enable file type detection and language-specific indenting
filetype plugin indent on
syntax on
