" Use color syntax highlighting.
syntax on

" Color specifications. Change them as you would like.
"
hi Comment      term=none       ctermfg=gray    guifg=Gray
hi Constant     term=underline  ctermfg=cyan    guifg=Cyan
hi Identifier   term=underline  ctermfg=green   guifg=White
hi Statement    term=bold       ctermfg=white   guifg=White
hi PreProc      term=underline  ctermfg=magenta guifg=Magenta
hi Type         term=underline  ctermfg=white   guifg=White
hi Special      term=bold       ctermfg=blue    guifg=Blue
hi Nontext      term=bold       ctermfg=red     guifg=Red
hi Normal       guifg=Yellow    guibg=#00007F
hi Normal       ctermfg=darkgreen

hi Comment      cterm=none      gui=none
hi Constant     cterm=bold      gui=none
hi Identifier   cterm=none      gui=none
hi Statement    cterm=bold      gui=none
hi PreProc      cterm=bold      gui=none
hi Type         cterm=bold      gui=none
hi Special      cterm=bold      gui=none
hi NonText      cterm=bold      gui=none

" Special highlighting for XML
hi xmlTag ctermfg=blue cterm=bold guifg=white
hi xmlTagName ctermfg=blue cterm=bold guifg=white
hi xmlEndTag ctermfg=blue cterm=bold guifg=white

" Options.

set autoindent
set fileformat=unix     " No crazy CR/LF
set nojoinspaces        " One space after a "." rather than 2
set ruler               " Show the line position at the bottom of the window
set showmatch           " Show parentheses matching
set whichwrap=<,>,[,],h,l " Allows for left/right keys to wrap across lines
set writebackup         " Write temporary backup files in case we crash
" I don't know why I need this...
augroup cprog
     au!
     augroup end

    " Based on VIM tip 102: automatic tab completion of keywords
     function InsertTabWrapper(dir)
         let col = col('.') - 1
            if !col || getline('.')[col - 1] !~ '\k'
                return "\<tab>"
            elseif "back" == a:dir
                return "\<c-p>"
            else
                return "\<c-n>"
            endif
     endfunction

"     inoremap <tab>
"     <c-r>=InsertTabWrapper('fwd')<cr>
"     inoremap <s-tab>
"     <c-r>=InsertTabWrapper('back')<cr>
"
     set encoding=utf-8


" keep visual mode on after indentation
vnoremap < <gv
vnoremap > >gv

" Vundle https://github.com/gmarik/vundle

set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
Bundle 'goldfeld/vim-seek'
" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
" non github repos
Bundle 'git://git.wincent.com/command-t.git'
" ...

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

