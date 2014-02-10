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

" Turn on Line nubmers
set number

set hlsearch
set incsearch
set ignorecase
set history=1000
set cursorline
set autoindent
if has("unnamedplus")
  set clipboard=unnamedplus
elseif has("clipboard")
  set clipboard=unnamed
endif

set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2

set fileformat=unix     " No crazy CR/LF
set nojoinspaces        " One space after a "." rather than 2
set ruler               " Show the line position at the bottom of the window
set showmatch           " Show parentheses matching
set whichwrap=<,>,[,],h,l " Allows for left/right keys to wrap across lines
set writebackup         " Write temporary backup files in case we crash
" I don't know why I need this...
"augroup cprog
"  au!
"augroup end

"     inoremap <tab>
"     <c-r>=InsertTabWrapper('fwd')<cr>
"     inoremap <s-tab>
"     <c-r>=InsertTabWrapper('back')<cr>

set encoding=utf-8


" keep visual mode on after indentation
vnoremap < <gv
vnoremap > >gv

" Vundle https://github.com/gmarik/vundle

set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Nerdtree
  " Open on start
  " autocmd vimenter * NERDTree
let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=0
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.pyc','\~$','\.swo$','\.swp$','\.git','\.hg','\.svn','\.bzr']
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
" Fugitive, the Git Manager
Bundle 'tpope/vim-fugitive'
" JavaScript, plugin for JS syntax and indentation
Bundle 'pangloss/vim-javascript'
Bundle 'Lokaltog/vim-easymotion'
" EditorConfig
Bundle 'editorconfig/editorconfig-vim'
" Multiple Cursors
Bundle 'terryma/vim-multiple-cursors'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
Bundle 'goldfeld/vim-seek'

" color scheme
Bundle 'Lokaltog/vim-distinguished'
Bundle 'altercation/vim-colors-solarized'

" NerdTREE, the file browser
Bundle 'scrooloose/nerdtree'
" tabs for NerdTree
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'ervandew/supertab'
" status bar
Bundle 'bling/vim-airline'
Bundle 'scrooloose/syntastic'
Bundle 'kien/ctrlp.vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'myusuf3/numbers.vim'
Bundle 'corntrace/bufexplorer'
" vim-scripts repos
Bundle 'L9'
Bundle 'closetag.vim'
" Bundle 'git://git.wincent.com/command-t.git'

" a good setting for git commit messages as well
" http://zachholman.com/talk/more-git-and-github-secrets/
filetype plugin indent on     " required by Vundle


"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

""""""""""""""""""""""""""""""""""""""""""""""""""
" Tell vim to remember certain things when we exit
" " http://vim.wikia.com/wiki/VimTip80
" """"""""""""""""""""""""""""""""""""""""""""""""""
"
"  '10 : marks will be remembered for up to 10 previously edited files
"  "100 : will save up to 100 lines for each register
"  :20 : up to 20 lines of command-line history will be remembered
"  % : saves and restores the buffer list
"  n... : where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

" when we reload, tell vim to restore the cursor to the saved position
augroup JumpCursorOnEdit
  au!
  autocmd BufReadPost *
  \ if expand("<afile>:p:h") !=? $TEMP |
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \ let JumpCursorOnEdit_foo = line("'\"") |
  \ let b:doopenfold = 1 |
  \ if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
  \ let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
  \ let b:doopenfold = 2 |
  \ endif |
  \ exe JumpCursorOnEdit_foo |
  \ endif |
  \ endif
  " Need to postpone using "zv" until after reading the modelines.
  autocmd BufWinEnter *
  \ if exists("b:doopenfold") |
  \ exe "normal zv" |
  \ if(b:doopenfold > 1) |
  \ exe "+".1 |
  \ endif |
  \ unlet b:doopenfold |
  \ endif

"save folds on exit
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

" turn on spell check in git commit messages
autocmd Filetype gitcommit setlocal spell textwidth=72

" color scheme
set background=dark
colorscheme solarized
