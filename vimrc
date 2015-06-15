" Use color syntax highlighting.
syntax on

" Color specifications. Change them as you would like.
"
"hi Comment      term=none       ctermfg=gray    guifg=Gray
"hi Constant     term=underline  ctermfg=cyan    guifg=Cyan
"hi Identifier   term=underline  ctermfg=green   guifg=White
"hi Statement    term=bold       ctermfg=white   guifg=White
"hi PreProc      term=underline  ctermfg=magenta guifg=Magenta
"hi Type         term=underline  ctermfg=white   guifg=White
"hi Special      term=bold       ctermfg=blue    guifg=Blue
" hi Nontext      term=bold       ctermfg=red     guifg=Red
" hi Normal       guifg=Yellow    guibg=#00007F
" hi Normal       ctermfg=darkgreen

" hi Comment      cterm=none      gui=none
" hi Constant     cterm=bold      gui=none
" hi Identifier   cterm=none      gui=none
" hi Statement    cterm=bold      gui=none
" hi PreProc      cterm=bold      gui=none
" hi Type         cterm=bold      gui=none
" hi Special      cterm=bold      gui=none
" hi NonText      cterm=bold      gui=none

" Special highlighting for XML
" hi xmlTag ctermfg=blue cterm=bold guifg=white
" hi xmlTagName ctermfg=blue cterm=bold guifg=white
" hi xmlEndTag ctermfg=blue cterm=bold guifg=white

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

" turn off concealing which modifies code not under the cusor
let g:vim_json_syntax_conceal = 0

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

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/Vundle.vim'

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

" force syntax
au! BufRead,BufNewFile *.json set filetype=json

" avoid permission-to-write issues! /thanks @pkrumins
noremap sudow w !sudo tee % >/dev/null

" My Bundles here:
"
" original repos on github
" Fugitive, the Git Manager
Plugin 'tpope/vim-fugitive'
" JavaScript, plugin for JS syntax and indentation
Plugin 'https://github.com/othree/yajs.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'nathanaelkane/vim-indent-guides'
" EditorConfig
Plugin 'editorconfig/editorconfig-vim'
" Multiple Cursors
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-rails.git'
Plugin 'goldfeld/vim-seek'

" color scheme
Plugin 'flazz/vim-colorschemes'

" NerdTREE, the file browser
Plugin 'scrooloose/nerdtree'
" tabs for NerdTree
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'ervandew/supertab'
" status bar
Plugin 'bling/vim-airline'
" use the same status bar in tmux
Plugin 'edkolev/tmuxline.vim'
" automatically set the closing bracket
Plugin 'Raimondi/delimitMate'
" yell at you if you don't commit
Plugin 'esneider/YUNOcommit.vim'

" Syntaxes
Plugin 'jakar/vim-json'
Plugin 'plasticboy/vim-markdown'
Plugin 'toyamarinyon/vim-swift'
Plugin 'mmalecki/vim-node.js'
" tern gives JS autocomplete and selection super powers
Plugin 'marijnh/tern_for_vim'

Plugin 'scrooloose/syntastic'

Plugin 'kien/ctrlp.vim'

" gist support
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'

Plugin 'airblade/vim-gitgutter'
Plugin 'myusuf3/numbers.vim'
Plugin 'corntrace/bufexplorer'
" vim-scripts repos
Plugin 'L9'
Plugin 'closetag.vim'
Plugin 'phd'
" Plugin 'git://git.wincent.com/command-t.git'

" All of your Plugins must be added before the following line
call vundle#end()            " required
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
" NOTE: comments after Plugin command are not allowed..

" Gist
let g:gist_post_private = 1
let g:gist_show_privates = 1
let g:gist_detect_filetype = 1
let g:gist_clip_command = 'reattach-to-user-namespace pbcopy'

" vim airline

" so that airline appears in the first split
set laststatus=2
let g:airline_powerline_fonts=1

" setup syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers = ['eslint']

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
  \ if (b:doopenfold > 1) |
  \ exe "+".1 |
  \ endif |
  \ unlet b:doopenfold |
  \ endif

"save folds on exit
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview
" turn on spell check in git commit messages
autocmd Filetype gitcommit setlocal spell textwidth=72

" auto-set paste mode in tmux, disables auto-indenting while pasting
" https://coderwall.com/p/if9mda
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" cursor shape with tmux and iterm
" I'm not sure this actually does anything?
" http://tangosource.com/blog/a-tmux-crash-course-tips-and-tweaks/
if exists('$ITERM_PROFILE')
  if exists('$TMUX')
    let &t_SI = "\<Esc>[3 q"
    let &t_EI = "\<Esc>[0 q"
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif
end

" vp doesn't replace paste buffer
" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
function! RestoreRegister()
  let @= s:restore_reg
   return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()
" set to 256 colors
if $TERM == "xterm-256color"
  set t_Co=256
endif
" set color scheme
set background=dark
colorscheme molokai

