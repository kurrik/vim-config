scriptencoding utf-8

" ### vim-plug: Package manager
" See https://github.com/junegunn/vim-plug
" Automatically download vim-plug, if not present.
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  echo 'vim-plug not installed, downloading'
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  echo 'vim-plug downloaded, will install plugins once vim loads'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ### Plugins: Start
call plug#begin()

" Monokai color scheme https://vimawesome.com/plugin/vim-monokai-the-story-of-us.
Plug 'sickill/vim-monokai'

" Syntax highlighting for a ton of languages.
Plug 'sheerun/vim-polyglot'

" ### Plugins: End
call plug#end()

" ### Vim: Mouse
" Mouse support.
set mouse=a

" ### Vim: Colors
" Say we have 256 color terminal.
set t_Co=256
set termguicolors
" Installed with vim-plug.
colorscheme monokai

" ### Vim: Directories
" Move backups out of the file path.
set directory=~/.tmp/nvim/swp
set backupdir=~/.tmp/nvim/backup

" ### Vim: Terminals
" Move into insert mode when entering a terminal.
autocmd TermOpen * startinsert
autocmd BufEnter term://* startinsert
" Move into normal mode when leaving a terminal.
autocmd BufLeave term://* stopinsert

" ### Windows: Explicit line endings.
set fileformat=unix
set fileformats=unix,dos

" ### Windows: Fix Backspace.
" See http://stackoverflow.com/questions/5419848/
set backspace=indent,eol,start

" ### Tmux: Copy and paste
" See https://coderwall.com/p/j9wnfw
set clipboard=unnamed

" ### Tmux: Cursor
" See https://dougblack.io/words/a-good-vimrc.html#tmux
" Allows the cursor to change from block to vertical line in tmux.
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" ### Editing: Tabs and wrapping
" Show tabs as characters.
set list
set listchars=tab:>-
" Tabs are 8 spaces wide.  Use 2 spaces where possible.
set tabstop=8
set softtabstop=2
set shiftwidth=2
set expandtab
" Don't wrap long lines.
set nowrap
set textwidth=0

" ### Editing: Keys
" Press `jj` quickly to get out of edit mode. 
imap jj <Esc>

" ### Editing: Settings
" Show line numbers.
set number
" Autocomplete in the command line shows a menu with options.
set wildmenu
" Highlight matching parens.
set showmatch
" Highlight matches.
set hlsearch
" Search as characters are entered.
set incsearch

" ### Editing: File Types
filetype on
syntax enable

" ### Editing: File browser
" No banner.
let g:netrw_banner = 0
" View type (use i to cycle through views).
let g:netrw_liststyle = 3
" Open files in previous window.
let g:netrw_browse_split = 4
let g:netrw_altv = 1
" Size of the browser in pct.
let g:netrw_winsize = 25
" 
" Open / close browser with Ctrl-n
map <C-n> :Vexplore<CR>
" Use :FindMe
