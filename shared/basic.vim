" Basic settings that are common to both Vim and Neovim
" This file is sourced by both .vimrc and nvim/init.lua

" Display
set number
set relativenumber
set signcolumn=yes
set showmatch
set scrolloff=4

" Indentation
set tabstop=2
set shiftwidth=2
set expandtab

" File handling
set fileformats=unix
set autoread
set noswapfile
set nobackup
set undofile

" Search
set ignorecase
set smartcase
set incsearch

" UI/UX
set mouse=a
set clipboard=unnamedplus
" Spell check is distracting in source code; enable it only for prose
" filetypes (see the FileType autocmd below) rather than globally.
set nospell
set timeoutlen=400

" Enable spell check for prose-oriented filetypes only
augroup spell_prose
  autocmd!
  autocmd FileType text,markdown,html,gitcommit,rst,asciidoc,tex,mail setlocal spell
augroup END

" Terminal
if has('nvim')
  " Neovim-specific terminal settings
  nnoremap <leader>t :split \| terminal<CR>
  tnoremap <Esc> <C-\><C-n>
else
  " Vim-specific terminal settings
  nnoremap <leader>t :terminal<CR>
endif
