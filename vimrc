" Colors and styles
colorscheme wombat
set number
set ruler
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Bitstream\ Vera\ Sans\ Mono\ 10
  else
    set guifont=Bitstream\ Vera\ Sans\ Mono:h13
  endif
endif
let NERDTreeShowHidden=1

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
autocmd BufRead,BufNewFile *.go setfiletype go
autocmd FileType go setlocal noexpandtab shiftwidth=8 softtabstop=8
autocmd FileType go highlight SpecialKey ctermbg=darkgray guibg=#333333
filetype indent on

" Makefiles
autocmd FileType make setlocal noexpandtab shiftwidth=8 softtabstop=8
autocmd FileType make highlight SpecialKey ctermbg=darkgray guibg=#333333

" Makefiles
autocmd FileType xml setlocal noexpandtab shiftwidth=8 softtabstop=8
autocmd FileType xml highlight SpecialKey ctermbg=darkgray guibg=#333333

" HTML escapes
" Usage: visual select lines, execute ctrl+h
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
map <silent> <c-u> :call HtmlUnEscape()<CR>
