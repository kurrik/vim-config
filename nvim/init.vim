" Vim: Directories
set directory=~/.tmp/nvim/swp
set backupdir=~/.tmp/nvim/backup

" Windows: Explicit line endings.
set fileformat=unix
set fileformats=unix,dos

" Windows: Fix Backspace.
" See http://stackoverflow.com/questions/5419848/
set backspace=indent,eol,start

" TMux: Copy and paste
" See https://coderwall.com/p/j9wnfw
set clipboard=unnamed

" Editing: Tabs and wrapping
set list
set listchars=tab:>-
set tabstop=8
set softtabstop=2
set shiftwidth=2
set expandtab
set nowrap
set textwidth=0

" Editing: Keys
imap jj <Esc>

" Editing: Colors
set termguicolors

" Editing: File Types
filetype on


