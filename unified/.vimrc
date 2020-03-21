filetype indent on
filetype plugin on 
let mapleader = "\<Space>"
set autoindent
set expandtab
set foldlevelstart=99
set ignorecase
set mouse=a
set shiftwidth=2
set smartcase
set softtabstop=2
set spell
set title
set visualbell

nmap <nowait> <Leader>1 :TlistToggle<CR>

hi SpellBad cterm=undercurl ctermbg=None ctermfg=LightRed

" Highlight the current line
hi CursorLine cterm=none ctermbg=234
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

"Airline configs
set noshowmode " this is redundant with airline
let g:airline_left_sep = '▖'
let g:airline_right_sep = '▅'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#ale#enabled = 1

"ALE
let g:ale_completion_enabled = 1
let g:ale_lint_delay = 1000
let g:ale_set_balloons = 1
nmap <nowait> <Leader>2 <Plug>(ale_fix)
