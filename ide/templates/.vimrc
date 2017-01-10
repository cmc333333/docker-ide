set nocompatible
set backspace=indent,eol,start
syntax on
set wm=2
set sts=2
set sw=2
set tw=78
set expandtab
set autoindent
set mouse=a
set ignorecase
set bg=dark
set bs=2
set spell
set ww=b,s,<,>,[,]
set smartcase
set title
set ruler
set visualbell
set showcmd
filetype indent on
filetype plugin on 
set foldmethod=marker
set foldmarker={,}
set foldlevel=1
set encoding=utf-8

let TList_Process_File_Always = 1
noremap <F4> :TlistToggle<CR>
noremap <F6> :NERDTree<CR>

call pathogen#infect()

"Airline
set ttimeoutlen=50
set laststatus=2
set noshowmode
let g:airline_left_sep = '▖'
let g:airline_right_sep = '▅'
let g:airline_theme='dark'
let g:airline#extensions#whitespace#enabled = 0

hi SpellBad cterm=undercurl ctermbg=None ctermfg=LightRed
hi CursorLine cterm=none ctermbg=234

autocmd FileType * if &omnifunc != '' | call SuperTabChain(&omnifunc, "<c-p>") | call SuperTabSetDefaultCompletionType("<c-x><c-u>") | endif

augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END
