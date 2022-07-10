scriptencoding utf-8

" ### vim-plug: Package manager
" See https://github.com/junegunn/vim-plug
" Automatically download vim-plug, if not present.
" Run :PlugInstall to get new plugins!
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  echo 'vim-plug not installed, downloading'
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  echo 'vim-plug downloaded, will install plugins once vim loads'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ### Plugins: Start
call plug#begin()

" Monokai color scheme - https://vimawesome.com/plugin/vim-monokai-the-story-of-us.
Plug 'sickill/vim-monokai'

" Syntax highlighting for a ton of languages.
Plug 'sheerun/vim-polyglot'

" File tree - https://github.com/kyazdani42/nvim-tree.lua
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

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
" Set width for formatting long blocks of text (e.g. gq)
set textwidth=80

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

"### Lang: Go
function! Goformat()
  let regel=line(".")
  %!gofmt
  call cursor(regel, 1)
endfunction
autocmd BufRead,BufNewFile,BufEnter *.go setfiletype go
autocmd FileType go setlocal noexpandtab shiftwidth=8 softtabstop=8
autocmd Filetype go command! Fmt call Goformat()
filetype indent on

"### Plugins: NvimTree - https://github.com/kyazdani42/nvim-tree.lua
lua << EOF
  require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
      adaptive_size = true,
      mappings = {
        list = {
          { key = "u", action = "dir_up" },
        },
      },
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = false,
    },
    update_focused_file = {
      enable = true,
      update_root = false,
      ignore_list = {},
    },
  })
EOF

nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
" NvimTreeOpen and NvimTreeClose are also available if you need them

set termguicolors " this variable must be enabled for colors to be applied properly
