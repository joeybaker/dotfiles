" sections via: http://dougblack.io/words/a-good-vimrc.html

"
" UI CONFIG
"
set number " Turn on Line nubmers
set showcmd " show command in bottom bar, doesn't actually work b/c of airline
set cursorline " highlight the current line
set wildmenu " visual autocomplete for command menu
set lazyredraw " redraw only when we need to, should speed up macros and such
set showmatch " Show parentheses matching

"
" SEARCH
"

set incsearch " incremental search. moves through the file as you search
set hlsearch " highlight search. highlights the matches

"
" FOLDING
"

set foldenable " enable folding
set foldlevelstart=10 " 0 is all collapsed. 99 is all open
set foldnestmax=10      " folds can be nested. more than 10 is crazy
set foldmethod=indent   " fold on indent level. :help foldmethod for more

"
" SPACING
"

set shiftwidth=2
set tabstop=2 " 2 spaces per tab
set softtabstop=2 " the spaces in a tab when hitting the TAB key
set expandtab " turn the TAB key into spaces

"
" CUSTOM MAPPING
"

" Quickly select text you just pasted:
" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
noremap gV `[v`]`


" open ag.vim
nnoremap <leader>a :Ag

" keep visual mode on after indentation
vnoremap < <gv
vnoremap > >gv


"
" STARTUP FUNCTIONS
"

" cursor change for tmux
" allows cursor change in tmux mode
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

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

" leave the backup files prefiex with ~ on, but save to /tmp instead of cwd
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

"
" AUTOGROUPS
"

" Pencil setup
augroup pencil
autocmd!
  autocmd FileType markdown,mkd,md call pencil#init()
  autocmd FileType text            call pencil#init()
augroup END


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


set ignorecase
set history=1000
set autoindent
if has("unnamedplus")
  set clipboard=unnamedplus
elseif has("clipboard")
  set clipboard=unnamed
endif

" turn off concealing, which modifies code not under the cusor
let g:vim_json_syntax_conceal = 0

set fileformat=unix     " No crazy CR/LF
set nojoinspaces        " One space after a "." rather than 2
set ruler               " Show the line position at the bottom of the window
set whichwrap=<,>,[,],h,l " Allows for left/right keys to wrap across lines
set writebackup         " Write temporary backup files in case we crash

set encoding=utf-8


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
" per http://www.swamphogg.com/2015/vim-setup/
au! BufRead,BufNewFile *.markdown set filetype=mkd
au! BufRead,BufNewFile *.md       set filetype=mkd

" avoid permission-to-write issues! /thanks @pkrumins
noremap sudow w !sudo tee % >/dev/null

" My Bundles here:
"
" original repos on github
" Fugitive, the Git Manager
Plugin 'tpope/vim-fugitive'
" JavaScript, plugin for JS syntax and indentation
Plugin 'https://github.com/othree/yajs.vim'
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
Plugin 'yosiat/oceanic-next-vim'

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
" Pencil, for writing and markdown
Plugin 'reedes/vim-pencil'

" Syntaxes
Plugin 'jakar/vim-json'
Plugin 'plasticboy/vim-markdown'
Plugin 'toyamarinyon/vim-swift'
Plugin 'mmalecki/vim-node.js'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

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
let g:gist_clip_command = 'pbcopy'

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

"
" PLUGIN CONFIG
"

" ag starts searching from project root instead of cwd
let g:ag_working_path_mode="r"

" Make Ctrl-P plugin a lot faster for Git projects
" configures CtrlP to use git or silver searcher for autocompletion
" NOTE: this means you'll need a .agignore file to exculde from search
let g:ctrlp_use_caching = 0
if executable('ag')
 set grepprg=ag\ --nogroup\ --nocolor
 let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
 let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
 let g:ctrlp_prompt_mappings = {
     \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>']
     \ }
endif

" ctrlp: sort file matches top to bottom
let g:ctrlp_match_window = 'bottom,order:ttb'
" ctrlp: always open in a new buffer
let g:ctrlp_switch_buffer = 0
" ctrlp: allows us to change the cwd during a session
let g:ctrlp_working_path_mode = 0


"
" # COLORS
"

" set to 256 colors
if $TERM == "xterm-256color"
  set t_Co=256
endif
" set color scheme
set background=dark
colorscheme molokai

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

