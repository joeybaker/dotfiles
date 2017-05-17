" sections via: http://dougblack.io/words/a-good-vimrc.html

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

  " Think of sensible.vim as one step above 'nocompatible' mode: a universal set of defaults that (hopefully) everyone can agree on.
  Plug 'tpope/vim-sensible'

  " EditorConfig
  Plug 'editorconfig/editorconfig-vim'

  " status bar
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  " use the same status bar in tmux
  Plug 'edkolev/tmuxline.vim'

  " yell at you if you don't commit
  Plug 'esneider/YUNOcommit.vim'

  " better tmux and vim integration
  Plug 'wincent/terminus'

  " Flow for js autocompletion
  Plug 'flowtype/vim-flow'

  " file searching is good
  Plug 'kien/ctrlp.vim'

  " remember cursor position and such when opening a file
  Plug 'farmergreg/vim-lastplace'

  " molokai color scheme
  Plug 'tomasr/molokai'

  " This seems to be a better version of oceanic next
  Plug 'mhartington/oceanic-next'

  " Keybindings for commenting lines
  Plug 'scrooloose/nerdcommenter'

  " yell at you if you don't commit
  Plug 'esneider/YUNOcommit.vim'

  " autocompletion via neocomplete
  Plug 'Shougo/neocomplete.vim'
  " autocompletion via deoplete
  " flow autocompleteion
  Plug 'wokalski/autocomplete-flow'
  " For func argument completion
  Plug 'Shougo/neosnippet'
  Plug 'Shougo/neosnippet-snippets'

  " seek with two chars instead on one on a single line
  Plug 'goldfeld/vim-seek'

  " Syntaxes
  Plug 'jakar/vim-json'
  Plug 'plasticboy/vim-markdown'
  Plug 'toyamarinyon/vim-swift'
  Plug 'mmalecki/vim-node.js'
  Plug 'pangloss/vim-javascript'
  Plug 'mxw/vim-jsx'
  Plug 'avakhov/vim-yaml'
  Plug 'tpope/vim-git'
  Plug 'tmux-plugins/vim-tmux'
  Plug 'tpope/vim-rails'

  " Spellcheck for certain file types
  Plug 'reedes/vim-lexical'

  " Better markdown editing
  Plug 'reedes/vim-pencil'

  " Multiple Cursors
  Plug 'terryma/vim-multiple-cursors'

  " Better in-file searching
  Plug 'wincent/loupe'

  " show git diff in the gutter
  Plug 'airblade/vim-gitgutter'

  " relative line numbers
  Plug 'myusuf3/numbers.vim'

  " Indent Guides is a plugin for visually displaying indent levels in Vim.
  Plug 'nathanaelkane/vim-indent-guides'

  " async linting, b/c it's 2017
  Plug 'w0rp/ale'

  " ack + the silver searcher for fast in project find
  Plug 'mileszs/ack.vim'

  " expand regions for easier selections
  Plug 'terryma/vim-expand-region'

  " surround allows using `s` to direct quotes etc
  Plug 'tpope/vim-surround'

  " search and replace across project
  Plug 'brooth/far.vim'

" Initialize plugin system
call plug#end()







"
" UI CONFIG
"
set number " Turn on Line nubmers
set cursorline " highlight the current line
set lazyredraw " redraw only when we need to, should speed up macros and such
set showmatch " Show parentheses matching
set updatetime=250 " as reccomended by gitgutter https://github.com/airblade/vim-gitgutter#getting-started
set showcmd " shows the current command to the right below airline

" link to system clipboard
if has("unnamedplus")
  set clipboard=unnamedplus
elseif has("clipboard")
  set clipboard=unnamed
endif

" leave the backup files prefiex with ~ on, but save to /tmp instead of cwd
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" Write temporary backup files in case we crash
set writebackup

" More natural split opening
" https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally#more-natural-split-opening
set splitbelow
set splitright





"
" SPACING
"

set shiftwidth=2
set tabstop=2 " 2 spaces per tab
set softtabstop=2 " the spaces in a tab when hitting the TAB key
" disable, I think smarttab does this? in vim-sensible
" set expandtab " turn the TAB key into spaces
set fileformat=unix     " No crazy CR/LF
set nojoinspaces        " One space after a "." rather than 2




"
" CUSTOM MAPPING
"

" keep visual mode on after indentation
vnoremap < <gv
vnoremap > >gv

" map leader key
let mapleader=","

" Easier split navigations
" https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally#easier-split-navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>






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






"
" AUTOGROUPS
"

" turn on spell check in git commit messages
autocmd Filetype gitcommit setlocal spell textwidth=72







"
" PLUGIN CONFIG
"


" vim airline
"
" so that airline appears in the first split
" set laststatus=2
" via https://gist.github.com/bsag/39eb930087c46521b763
let g:airline_powerline_fonts = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#virtualenv#enabled = 0
let g:airline#extensions#tmuxline#enabled = 0
let g:airline_inactive_collapse = 0
let g:virtualenv_auto_activate = 1

" for tmuxline
let g:tmuxline_preset = 'full'
let g:airline_theme='oceanicnext'

" Do not draw separators for empty sections (only for the active window) >
let g:airline_skip_empty_sections = 1




" Make Ctrl-P plugin a lot faster for Git projects
" configures CtrlP to use git or silver searcher for autocompletion
" NOTE: this means you'll need a .agignore file to exculde from search
" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
let g:ctrlp_use_caching = 0
if executable('ag')
 set grepprg=ag\ --nogroup\ --nocolor
 let g:ctrlp_user_command = 'ag %s -l --smart-case --skip-vcs-ignores --nocolor -g ""'
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
" allow finding dotfiles using CtrlP
let g:ctrlp_show_hidden=1
" prevent CtrlP from caching directory listings, b/c silver searcher is fast
let g:ctrlp_use_caching=0

" ag starts searching from project root instead of cwd
let g:ag_working_path_mode="r"






" NERDComment
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1









" flow
" we don't want the autofix window on save
let g:flow#enable = 0










" YouCompleteMe
" let g:ycm_error_symbol = '🔴'
" let g:ycm_warning_symbol = '🔸'
" let g:ycm_complete_in_comments = 1
" " pre-populate the autocomplete with language syntax
" let g:ycm_seed_identifiers_with_syntax = 0





" Neocomplete

"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 2

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" this is too much junk, too many bad results
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" Perl autocopmplete. For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'





" neosnippet
let g:neosnippet#enable_completed_snippet = 1






" goldfeld/vim-seek
let g:SeekKey = 't'
let g:SeekBackKey = 'T'






" pencil and lexical
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd,md call pencil#init({'autoformat': 1})
                              " lexical is a good idea, but
                              " it slows down neocomplete to
                              " a crawl
                               " \ | call lexical#init()
  autocmd FileType text,txt     call pencil#init({'wrap': 'hard'})
                        \ | call lexical#init()
augroup END

" the default is hard
let g:pencil#wrapModeDefault = 'soft'
let g:pencil#conceallevel = 0     " 0=disable, 1=one char, 2=hide char, 3=hide all (def)









" gitgutter
let g:gitgutter_enabled = 1
let g:gitgutter_realtime = 200
let g:gitgutter_eager = 200






" ale linting
let g:ale_sign_error = '🔴'
let g:ale_sign_warning = '🔸'





" ack, use the_silver_searcher
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case --skip-vcs-ignores'
endif
nnoremap <Leader>a :Ack<space>






" far, set a similar leader as ack b/c they do similar things
nnoremap <Leader>A :Far<space>







" expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)













"
" # Custom Functions
"

" vp doesn't replace paste buffer
" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()



"
" # COLORS
"

" set to 256 colors
if $TERM == "xterm-256color"
  set t_Co=256
endif
" set color scheme
" colorscheme molokai
set background=dark

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

