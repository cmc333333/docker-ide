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
let g:airline#extensions#ale#enabled = 1

hi SpellBad cterm=undercurl ctermbg=None ctermfg=LightRed
hi CursorLine cterm=none ctermbg=234

let g:ackprg = 'ag --vimgrep'

autocmd FileType * if &omnifunc != '' | call SuperTabChain(&omnifunc, "<c-p>") | call SuperTabSetDefaultCompletionType("<c-x><c-u>") | endif

augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = "2"

if jedi#init_python()
  function! s:jedi_auto_force_py_version() abort
    let major_version = pyenv#python#get_internal_major_version()
    call jedi#force_py_version(major_version)
  endfunction
  augroup vim-pyenv-custom-augroup
    autocmd! *
    autocmd User vim-pyenv-activate-post   call s:jedi_auto_force_py_version()
    autocmd User vim-pyenv-deactivate-post call s:jedi_auto_force_py_version()
  augroup END
endif

let g:ale_lint_on_text_changed = 'never'
