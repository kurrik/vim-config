" Line endings (for windows)
set fileformat=unix
set fileformats=unix,dos

" Powerline
set encoding=utf-8
let g:Powerline_symbols = 'fancy'

" Colorscheme
" ===========
if $TERM == "cygwin"
  if has("gui_running")
    set t_Co=256
    set ttymouse=xterm2
    colorscheme wombat256
  else
    colorscheme wombat
  endif
elseif $TERM == "linux" || $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
  set t_Co=256
  set ttymouse=xterm2
  if has("gui_running")
    colorscheme wombat256
  else
    colorscheme last256
  endif
else
  colorscheme wombat
endif

" GUI where font can be overridden
if has("gui_running")
  if has("gui_gtk2")
    " Linux
    set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 10
  elseif $TERM == "cygwin"
    " Windows
    set guifont=Bitstream_Vera_Sans_Mono_for_Po:h11
  else
    " OSX
    set guifont=Bitstream\ Vera\ Sans\ Mono\ for\ Powerline:h13
  endif
endif

set autoread
augroup checktime
    au!
    if !has("gui_running")
        "silent! necessary otherwise throws errors when using command
        "line window.
        autocmd BufEnter        * silent! checktime
        autocmd CursorHold      * silent! checktime
        autocmd CursorHoldI     * silent! checktime
        "these two _may_ slow things down. Remove if they do.
        autocmd CursorMoved     * silent! checktime
        autocmd CursorMovedI    * silent! checktime
    endif
augroup END
set cmdheight=1
set mouse=a
set number
set ruler
syntax on


" NERDTree
" ========
let NERDTreeShowHidden=1
" Uncomment below to open at start.
" autocmd VimEnter * NERDTree
" autocmd VimEnter * wincmd w

" Some of the Following cribbed from
" http://superuser.com/questions/195022/vim-how-to-synchronize-nerdtree-with-current-opened-tab-file-path

" Returns true if NERDTree is open
function! s:isNTOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Returns true iff focused window is NERDTree window
function! s:isNTFocused()
  return -1 != match(expand('%'), 'NERD_')
endfunction

" calls NERDTreeFind iff NERDTree is active, current window contains a
" modifiable file, and we're not in vimdiff
function! s:syncTree()
  if &modifiable && s:isNTOpen() && !s:isNTFocused() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Kill vim if NERDTree is the primary buffer
function! s:arkKillIfNTPrimary()
  if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary")
    wincmd q
  endif
endfunction

" Mirror NERDTree across tabs
function! a:arkMirrorNT()
  if s:isNTOpen()
    NERDTreeMirror
  endif
endfunction

" Toggle NERDTree
function! s:arkToggleNT()
  NERDTreeToggle
  wincmd p
  " Call twice to scroll to file.
  call s:syncTree()
  call s:syncTree()
endfunction

" Map Ctrl-n to open/close NERDTree
map <C-n> :call s:arkToggleNT()<CR>

" Use :FindMe to jump to current buffer in NERDTree if editable
command! FindMe call s:syncTree()

" Mirror trees across tabs
autocmd BufEnter * call s:arkMirrorNT()

" Kill NERDTree if it's the last window
autocmd BufEnter * call s:arkKillIfNTPrimary()

" Highlight
" =========
" Highlight trailing spaces
highlight ExtraWhitespace ctermbg=yellow guibg=yellow
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Highlight over 80
if exists("+colorcolumn")
  set colorcolumn=81
else
  highlight OverLength ctermbg=red ctermfg=white guibg=#592929
  match OverLength /\%81v.\+/
endif

" Misc
" ====

" Backspace
" See http://stackoverflow.com/questions/5419848/
set backspace=indent,eol,start

" Copy and paste from tmux
" See https://coderwall.com/p/j9wnfw
set clipboard=unnamed

" Tabs and wrapping
set list
set listchars=tab:>-
set tabstop=8
set softtabstop=2
set shiftwidth=2
set expandtab
set nowrap
set textwidth=0

" Directories
if $TERM == "cygwin"
  set directory=~/vimfiles/swp
  set backupdir=~/vimfiles/backup
else
  set directory=~/.vim/swp
  set backupdir=~/.vim/backup
endif

" Filetype exceptions
filetype on

" JS
" Install https://github.com/rdio/jsfmt
function! Jsformat()
  let regel=line(".")
  %!jsfmt --format=true
  call cursor(regel, 1)
endfunction
autocmd BufRead,BufNewFile,BufEnter *.js setfiletype javascript
autocmd FileType javascript setlocal expandtab shiftwidth=2 softtabstop=2
autocmd Filetype javascript command! JsFmt call Jsformat()

" Golang
function! Goformat()
  let regel=line(".")
  %!gofmt
  call cursor(regel, 1)
endfunction
autocmd BufRead,BufNewFile,BufEnter *.go setfiletype go
autocmd FileType go setlocal noexpandtab shiftwidth=8 softtabstop=8
autocmd Filetype go command! Fmt call Goformat()
filetype indent on

" Makefiles
autocmd FileType make setlocal noexpandtab shiftwidth=8 softtabstop=8
autocmd FileType make highlight SpecialKey ctermbg=darkgray guibg=#333333

" CPP
autocmd FileType cpp setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType cpp highlight SpecialKey ctermbg=yellow guibg=yellow

" XML
autocmd FileType xml setlocal noexpandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType xml highlight SpecialKey ctermbg=darkgray guibg=#333333

" Ruby
autocmd FileType rb setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType rb highlight SpecialKey ctermbg=darkgray guibg=#333333

" Pig
autocmd BufRead,BufNewFile *.pig set filetype=pig syntax=pig
autocmd BufRead,BufNewFile *.piglet set filetype=pig syntax=pig

" Aurora
autocmd BufRead,BufNewFile *.aurora set filetype=python syntax=python
autocmd BufRead,BufNewFile *.mesos set filetype=python syntax=python

" HTML escapes
" Usage: visual select lines, execute ctrl+h
"        Unescape by ctrl+g
function! HtmlEscape()
  silent s/&/\&amp;/eg
  silent s/</\&lt;/eg
  silent s/>/\&gt;/eg
endfunction

function! HtmlUnEscape()
  silent s/&lt;/</eg
  silent s/&gt;/>/eg
  silent s/&amp;/\&/eg
endfunction

map <silent> <c-h> :call HtmlEscape()<CR>
map <silent> <c-g> :call HtmlUnEscape()<CR>

" CtrlP
nmap ; :CtrlPBuffer<CR>
nmap \ :CtrlPTag<CR>
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0
let g:ctrlp_custom_ignore = {
 \  'dir':  '\v[\/](\.(git|hg|svn)|build|node_modules)$',
 \  'file': '\v\.(exe|so|dll|o|swp|pyc)$'
 \}
" Powerline
set laststatus=2
