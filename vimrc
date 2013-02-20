" Colors and styles
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
  set t_Co=256
endif

set number
set ruler
syntax on

" Powerline
let g:Powerline_symbols = 'fancy'

colorscheme wombat256
if has("gui_running")
  colorscheme wombat
  if has("gui_gtk2")
    set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 10
  else
    set guifont=Monaco\ for\ Powerline:h13
  endif
endif

" NERDTree
let NERDTreeShowHidden=1
autocmd VimEnter * NERDTree
autocmd BufEnter * NERDTreeMirror
autocmd VimEnter * wincmd w
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

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
set directory=~/.vim/swp
set backupdir=~/.vim/backup

" Filetype exceptions
filetype on

" Golang
function Goformat()
  let regel=line(".")
  %!gofmt
  call cursor(regel, 1)
endfunction
autocmd BufRead,BufNewFile *.go setfiletype go
autocmd FileType go setlocal noexpandtab shiftwidth=8 softtabstop=8
autocmd FileType go highlight SpecialKey 
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

" HTML escapes
" Usage: visual select lines, execute ctrl+h
"        Unescape by ctrl+g
function HtmlEscape()
  silent s/&/\&amp;/eg
  silent s/</\&lt;/eg
  silent s/>/\&gt;/eg
endfunction

function HtmlUnEscape()
  silent s/&lt;/</eg
  silent s/&gt;/>/eg
  silent s/&amp;/\&/eg
endfunction

map <silent> <c-h> :call HtmlEscape()<CR>
map <silent> <c-g> :call HtmlUnEscape()<CR>

" CtrlP
nmap ; :CtrlPBuffer<CR>
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0

" Powerline
set laststatus=2
