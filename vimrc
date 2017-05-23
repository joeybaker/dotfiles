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
  " flow autocompletion
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
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'avakhov/vim-yaml'
  Plug 'tpope/vim-git'
  Plug 'tmux-plugins/vim-tmux'
  Plug 'tpope/vim-rails'
  Plug 'fleischie/vim-styled-components'

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

  " being able to `:Gblame` is nice
  Plug 'tpope/vim-fugitive'

  " file management commands like :Move
  Plug 'tpope/vim-eunuch'
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

" always insert a new line at the end of the file
" (I'm not sure this works)
set fixendofline
set endofline





"
" SPACING
"

set shiftwidth=2
set tabstop=2 " 2 spaces per tab
set softtabstop=2 " the spaces in a tab when hitting the TAB key
" disable, I think smarttab does this? in vim-sensible
" set expandtab " turn the TAB key into spaces
" even though we want expand tab normally, make files are special
autocmd FileType make setlocal noexpandtab
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

" better tab navigations via http://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/
" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>b :enew<cr>

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

" use flow for jump to definition
nmap <leader>j :FlowJumpToDef<cr>




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
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

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
 let g:ctrlp_user_command = 'ag %s -l --hidden --smart-case --silent --nocolor -g ""'
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

" via http://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/
" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'

" Use a leader instead of the actual named binding
nmap <leader>p :CtrlP<cr>






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
" disable, doesn't seem to complete snippets with autocomplete?
" let g:neosnippet#enable_completed_snippet = 1






" goldfeld/vim-seek
let g:SeekKey = 't'
let g:SeekBackKey = 'T'






" pencil and lexical
function! Prose()
  " use hard wrapping to keep everything on the screen. markdown is smart
  " enough to still format correctly
  " but… it fucks with other things. Turning this off for now
  " call pencil#init({'wrap': 'hard"})
  call pencil#init()
  " lexical is a good idea, but it slows down neocomplete to a crawl
  " call lexical#init()
  " call litecorrect#init()
  " call textobj#quote#init()
  " call textobj#sentence#init()

  " manual reformatting shortcuts
  " nnoremap <buffer> <silent> Q gqap
  " xnoremap <buffer> <silent> Q gq
  " nnoremap <buffer> <silent> <leader>Q vapJgqap

  " force top correction on most recent misspelling
  nnoremap <buffer> <c-s> [s1z=<c-o>
  inoremap <buffer> <c-s> <c-g>u<Esc>[s1z=`]A<c-g>u

  " replace common punctuation
  iabbrev <buffer> -- –
  iabbrev <buffer> --- —
  iabbrev <buffer> << «
  iabbrev <buffer> >> »

  " open most folds
  setlocal foldlevel=20
  " disable numbers.vim. It doesn't play nicely and causes numbers to
  " appear/disappear when toggling modes
  call NumbersDisable()

  " replace typographical quotes (reedes/vim-textobj-quote)
  " map <silent> <buffer> <leader>qc <Plug>ReplaceWithCurly
  " map <silent> <buffer> <leader>qs <Plug>ReplaceWithStraight

  " highlight words (reedes/vim-wordy)
  " noremap <silent> <buffer> <F8> :<C-u>NextWordy<cr>
  " xnoremap <silent> <buffer> <F8> :<C-u>NextWordy<cr>
  " inoremap <silent> <buffer> <F8> <C-o>:NextWordy<cr>

  " enable spell checking. Disable languages that I don't use for perf
  setl spell spl=en_us fdl=4 noru nonu nornu
  " open folds on search http://vimdoc.sourceforge.net/htmldoc/options.html#'foldopen'
  setl fdo+=search
endfunction

augroup pencil
  autocmd!
  autocmd FileType markdown,mkd,md call Prose()
  autocmd FileType text,txt     call Prose()
                        " \ | call lexical#init()
  autocmd Filetype git,gitsendemail,*commit*,*COMMIT*
                            \   call pencil#init({'wrap': 'hard', 'textwidth': 72})
augroup END

" invoke manually by command for other file types
command! -nargs=0 Prose call Prose()

" the default is hard
let g:pencil#wrapModeDefault = 'soft'
let g:pencil#conceallevel = 0     " 0=disable, 1=one char, 2=hide char, 3=hide all (def)
let g:pencil#autoformat = 1      " 0=disable, 1=enable (def)
let g:pencil#textwidth = 80
let g:pencil#cursorwrap = 1     " 0=disable, 1=enable (def)
let g:pencil#conceallevel = 3     " 0=disable, 1=one char, 2=hide char, 3=hide all (def)
let g:pencil#concealcursor = 'c'  " n=normal, v=visual, i=insert, c=command (def)
" custom aireline config
let g:airline_section_x = '%{PencilMode()}'
" tell lexial to enable spelling
let g:lexical#spell = 1         " 0=disabled, 1=enabled
" show a list of suggestions with a Keybindings
let g:lexical#spell_key = '<leader>s'








" gitgutter
let g:gitgutter_enabled = 1
let g:gitgutter_realtime = 200
let g:gitgutter_eager = 200






" ale linting
let g:ale_sign_error = '🔴'
let g:ale_sign_warning = '🔸'

" use eslint_d instead of the local eslint for speed!
let g:ale_javascript_eslint_executable = 'eslint_d'





" ack, use the_silver_searcher
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case --silent --hidden'
endif
nnoremap <Leader>a :Ack<space>






" far, set a similar leader as ack b/c they do similar things
nnoremap <Leader>A :Far<space>







" expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)






" mutliple-cursors
" prevent a conflict with neocomplete
" https://github.com/terryma/vim-multiple-cursors#multiple_cursors_beforemultiple_cursors_after-default-nothing
" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction










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

