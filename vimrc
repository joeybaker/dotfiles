" sections via: http://dougblack.io/words/a-good-vimrc.html

" auto-install plug if needed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

  " Think of sensible.vim as one step above 'nocompatible' mode: a universal
  " set of defaults that (hopefully) everyone can agree on.
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
  Plug 'flowtype/vim-flow', { 'for': 'javascript' }

  " remember cursor position and such when opening a file
  Plug 'farmergreg/vim-lastplace'

  " molokai color scheme
  Plug 'tomasr/molokai'

  " This seems to be a better version of oceanic next
  Plug 'mhartington/oceanic-next'

  " Keybindings for commenting lines
  Plug 'scrooloose/nerdcommenter'

  " autocompletion
  if has('nvim')
    " neocomplete isn't nvim compatible, use deoplete instead
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    " go autocompletion
    Plug 'zchee/deoplete-go', { 'do': 'make'}

    " flow autocompletion
    " Note: this is unmaintained, but does seem to work https://github.com/wokalski/autocomplete-flow/issues/5#issuecomment-320328020
    Plug 'wokalski/autocomplete-flow', { 'for': 'javascript' }
  else
    " neocomplete for vim, it's not as good as deoplete but vim is old
    Plug 'Shougo/neocomplete.vim'
  endif
  " For function argument completion
  Plug 'Shougo/neosnippet'
  Plug 'Shougo/neosnippet-snippets'

  " seek with two chars instead on one on a single line
  Plug 'goldfeld/vim-seek'

  " Syntaxes
  Plug 'jakar/vim-json', { 'for': 'json' }
  Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
  Plug 'toyamarinyon/vim-swift', { 'for': 'swift' }
  Plug 'mmalecki/vim-node.js', { 'for': 'javascript' }
  Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
  Plug 'maxmellon/vim-jsx-pretty', { 'for': 'javascript' } "requires pangloss/vim-javascript or othree/yajs.vim
  Plug 'avakhov/vim-yaml', { 'for': 'yaml' }
  Plug 'tpope/vim-git'
  Plug 'tmux-plugins/vim-tmux'
  Plug 'jparise/vim-graphql'
  " disabled until https://github.com/fleischie/vim-styled-components/issues/23 gets fixed
  " Plug 'fleischie/vim-styled-components', { 'for': 'javascript' }
  " This branch fixes the above issue, but something is conflicting with this
  " and vim-javascript to cause all syntax highlighting to be randomly
  " disabled
  " Plug 'styled-components/vim-styled-components', { 'branch': 'rewrite', 'for': 'javascript' }
  Plug 'tpope/vim-rails', { 'for': 'ruby' }
  Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }
  Plug 'hail2u/vim-css3-syntax', { 'for': [ 'javascript', 'css' ] } " reccomended by vim-styled-components
  Plug 'vim-scripts/nginx.vim', { 'for': 'nginx' }

  " Spellcheck for certain file types
  Plug 'reedes/vim-lexical'

  " Better markdown editing
  Plug 'reedes/vim-pencil'

  " Multiple Cursors
  " disabled: it does not play with with InsertLeave autocommands
  " disabled: it doesn't work with autocomplete
  " https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db
  " Plug 'terryma/vim-multiple-cursors'

  " Better in-file searching
  Plug 'wincent/loupe'

  " show git diff in the gutter
  Plug 'airblade/vim-gitgutter'

  " Indent Guides is a plugin for visually displaying indent levels in Vim.
  Plug 'nathanaelkane/vim-indent-guides'

  " async linting, b/c it's 2017
  Plug 'w0rp/ale'

  " expand regions for easier selections
  Plug 'terryma/vim-expand-region'

  " surround allows using `s` to direct quotes etc
  Plug 'tpope/vim-surround'
  " makes surround commands repeatable with .
  Plug 'tpope/vim-repeat'

  " search and replace across project
  Plug 'skwp/greplace.vim'

  " being able to `:Gblame` is nice
  Plug 'tpope/vim-fugitive'

  " file management commands like :Move
  Plug 'tpope/vim-eunuch'

  " auto complete brackets, parens, etc
  " disabled, it's too buggy to be worth it.
  " Plug 'jiangmiao/auto-pairs'

  " auto nice `gf` smarts for require calls
  Plug 'moll/vim-node', { 'for': 'javascript' }

  " When using :Gblame from vim-fugitive, shows the commit message
  Plug 'tommcdo/vim-fugitive-blame-ext'

  " Run :ToGithub to open the current file/line in GH
  Plug 'tonchis/vim-to-github'

  " Navigate between both vim and tmux panes with just ctrl-<direction key>
  Plug 'christoomey/vim-tmux-navigator'

  " Enable jump-to-definition in ruby
  Plug 'xmisao/rubyjump.vim', { 'for': 'ruby' }

  " Vim sessions. This is paired with tmux for auto-restore of vim
  Plug 'tpope/vim-obsession'

  " :Reveal to show file in Finder
  Plug 'henrik/vim-reveal-in-finder'

  " easy moving from one line to multi
  Plug 'AndrewRadev/splitjoin.vim'

  " you should probably just use `gx`, but if you need to open multiple urls,
  " this is handy
  Plug 'henrik/vim-open-url'

  " see all the undo history, mapped to U below
  Plug 'mbbill/undotree'

  " fzf for fuzzy finding files. It's like ctrl-p but newer
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'

  " better handling of ruby which doesn't use curlies
  Plug 'vim-ruby/vim-ruby'

  " for a distraction free wirting experience
  Plug 'junegunn/goyo.vim'

  " easy motion is kinda nice
  Plug 'easymotion/vim-easymotion'

  " automatic indenting is good
  Plug 'tpope/vim-sleuth'

  " automatic ending keyword insertation for ruby, vimscript, C, and a few
  " others
  Plug 'tpope/vim-endwise'

  " auto close xml/html style tags on </
  Plug 'docunext/closetag.vim'

  " easy case conversion
  Plug 'tpope/vim-abolish'

  " Use vim to query databases. Plays well with vim-rails
  Plug 'tpope/vim-db'

  " can set the current directory to the project directory
  Plug 'airblade/vim-rooter'
" Initialize plugin system
call plug#end()







"
" UI CONFIG
"
set number " Turn on Line nubmers
set relativenumber " The current line will have the absolute number, but all other lines will be relative
set cursorline " highlight the current line
set lazyredraw " redraw only when we need to, should speed up macros and such
set showmatch " Show parentheses matching
set updatetime=250 " as reccomended by gitgutter https://github.com/airblade/vim-gitgutter#getting-started
set showcmd " shows the current command to the right below airline
set hidden " don't warn when switching buffers is buffer is unsaved https://stackoverflow.com/questions/2414626/unsaved-buffer-warning-when-switching-files-buffers

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

" save when switching buffers
" http://vim.wikia.com/wiki/Auto_save_files_when_focus_is_lost
set autowrite

" remove delay when leaving insert mode by airline
" https://github.com/vim-airline/vim-airline/wiki/FAQ#there-is-a-pause-when-leaving-insert-mode
set ttimeoutlen=10


" persist undo past leaving a buffer
" https://stackoverflow.com/questions/5969807/how-can-i-retain-vim-undo-history-but-disallow-hiding-modified-buffers
if filewritable(&undodir) == 0 | call mkdir(&undodir, "p") | endif
set undodir=~/.vim/undo
set undofile
" https://stackoverflow.com/questions/2732267/vim-loses-undo-history-when-changing-buffers
set undolevels=1000
set undoreload=10000

" don't show a preview window when doing autocompletion, it's silly an
" unecessary https://github.com/Shougo/deoplete.nvim/issues/298
set completeopt-=preview


" make `gf` work a little better in JavaScript files
" https://gist.github.com/latentflip/57bf8f9edde531ee979e
set suffixesadd+=.js
set path+=$PWD/node_modules



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

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>bn :enew<cr>

" Move to the next buffer
nmap <leader>l :bnext!<CR>

" Move to the previous buffer
nmap <leader>h :bprevious!<CR>

" Close all buffers
nmap <leader>bc :silent! bdelete! <c-a><CR><CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
function! BufferDelete()
  if &modified
    echohl ErrorMsg
    echomsg "No write since last change. Not closing buffer."
    echohl NONE
  else
    let s:total_nr_buffers = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))

    if s:total_nr_buffers == 1
        silent! bdelete!
        echo "Buffer deleted. Created new buffer."
    else
        silent! bdelete!
        " in vim, we need to go to the previous buffer. This doesn't appear to
        " be necessary in nvim
        " silent! bprevious!
        echo "Buffer deleted."
    endif
  endif
endfunction

nmap <leader>q :call BufferDelete()<CR>

" restrict commands to a filetype
" https://stackoverflow.com/a/20105502

" use flow for jump to definition
autocmd FileType javascript nmap <leader>j :FlowJumpToDef<CR>
autocmd FileType javascript.jsx nmap <leader>j :FlowJumpToDef<CR>
" use rubyjump.vim for jump to definition
autocmd FileType ruby nmap <silent> <leader>j <Plug>(rubyjump_cursor)
" use vim-go in go
autocmd FileType go nmap <silent> <leader>j <Plug>(go-def)

" get type under cursor
autocmd FileType javascript nmap <leader>t :FlowType<CR>
autocmd FileType javascript.jsx nmap <leader>t :FlowType<CR>
" get type under cursor
autocmd FileType go nmap <leader>t <Plug>(go-info)


" Autofix entire buffer with eslint_d:
" https://www.npmjs.com/package/eslint_d#automatic-fixing
autocmd FileType javascript nnoremap <leader>f mF:%!eslint_d --cache --stdin --fix-to-stdout<CR>`F

" Autofix entire buffer with python for JSON
" requires `json` to be installed
" `yarn global add json`
" https://github.com/trentm/json
autocmd FileType json nnoremap <leader>f mF:%!json<CR>`F

" map leader-s to save. This works even in insert mode!
" https://hashrocket.com/blog/posts/8-great-vim-mappings#number-1-save-file-with-leader-s
nnoremap <leader>s :w<cr>
inoremap <leader>s <C-c>:w<cr>

" copy the current file path
" http://vim.1045645.n5.nabble.com/Copy-the-full-path-of-the-file-opened-in-my-current-buffer-tt5721712.html#a5721716
nnoremap <Leader>yf :let @*=expand("%:p")<cr>

" via https://github.com/sdemjanenko/vimstuff/blob/master/.vimrc
" Use ,d (or ,dd or ,dj or 20,dd) to delete a line without adding it to the
" yanked stack (also, in visual mode)
nmap <silent> <leader>d "_d
vmap <silent> <leader>d "_d
" Quick yanking to the end of the line
nmap Y y$

" undotree
nnoremap U :UndotreeToggle<cr>






"
" STARTUP FUNCTIONS
"

" cursor change for tmux
" allows cursor change in tmux mode
if has('nvim')
  :set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor,a:blinkon0
  " restore cursor on vim exit
  au VimLeave * set guicursor=a:block-blinkon0
else
  " https://gist.github.com/andyfowler/1195581
  if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif
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

" save on focus lost, ignore buffers that have never been written
" http://vim.wikia.com/wiki/Auto_save_files_when_focus_is_lost
autocmd FocusLost * silent! wa

" setup the custom nginx syntax
au BufRead,BufNewFile */nginx/*.conf if &ft == '' | setfiletype nginx | endif






"
" PLUGIN CONFIG
"


" vim airline
"
" so that airline appears in the first split
" set laststatus=2
" via https://gist.github.com/bsag/39eb930087c46521b763
let g:airline_powerline_fonts = 1

" Use the highlight cache to speed up ruby https://github.com/vim-airline/vim-airline/issues/1026#issuecomment-322134816
let g:airline_highlighting_cache=1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
" Show just the filename
" let g:airline#extensions#tabline#fnamemod = ':t'
" rename label for buffers (default: 'buffers')
let g:airline#extensions#tabline#buffers_label = ''

let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#virtualenv#enabled = 0
let g:airline_inactive_collapse = 1
let g:virtualenv_auto_activate = 1

" for tmuxline
let g:tmuxline_preset = 'full'
" enable/disable tmuxline integration
" keep it disabled, we'll just rely on the tmuxline file. Re-enable if you
" want to change the theme
let g:airline#extensions#tmuxline#enabled = 0
" no need for the powerline separators, they just take up room
let g:tmuxline_powerline_separators = 0
" customize the sections https://github.com/edkolev/tmuxline.vim#custom-preset
let g:tmuxline_preset = {
      \'a'    : '',
      \'b'    : '',
      \'c'    : '',
      \'win'  : '#I #W',
      \'cwin' : '#I #W',
      \'x'    : '%a %d %b  %R',
      \'y'    : '',
      \'z'    : '#H'}


let g:tmuxline_theme = 'base16_spacemacs'
let g:airline_theme='base16_spacemacs'

" Do not draw separators for empty sections (only for the active window)
let g:airline_skip_empty_sections = 1

" determine whether inactive windows should have the left section collapsed to
" only the filename of that buffer.
let g:airline_inactive_collapse=1

" enable/disable showing a summary of changed hunks under source control. >
let g:airline#extensions#hunks#enabled = 1

" replace the branch indicator with the current working directory, followed by
" the filename.
" let g:airline_section_b = '%{getcwd()}'
" let g:airline_section_c = '%{getcwd()}%t'

" don't show the current branch, it takes up a bunch of space an it's usually
" visible in another winde
if winwidth(0) > 180
  let g:airline_section_b = airline#section#create(['hunks', 'branch'])
else
  let g:airline_section_b = airline#section#create(['hunks'])
endif

" replace the file encoding section, it's kinda worthless
" https://github.com/vim-airline/vim-airline/blob/466198adc015a9d81e975374d8e206dcf3efd173/autoload/airline/init.vim#L182
if winwidth(0) > 180
  let g:airline_section_y = airline#section#create_right(['ffenc'])
else
  let g:airline_section_y = ''
endif








" fzf
" https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2
let g:fzf_command_prefix = 'Fzf'

" map this just like ctrl-p
nnoremap <silent> <leader>p :FzfFiles<CR>
nnoremap <silent> <c-p> :FzfFiles<CR>
nnoremap <silent> ; :FzfBuffers<CR>

nnoremap <silent> <leader>a :FzfAg<CR>
" enable searching the word under the cursor
nnoremap <silent> <leader>wa :FzfAg <C-R><C-W><CR>


" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
let g:fzf_history_dir = '~/.vim/fzf'

" show a history of visited files. Useful to undo a closed buffer.
nmap <leader>b :FzfHistory<CR>


if executable('rg')
  set grepprg=rg\ --vimgrep
        "\ --no-heading\ --ignore-case\ --hidden\ --follow\ --glob\ '!**/{.git,node_modules,vendor,dist,.cache,__snapshots__,coverage,tmp}/*'\ --glob\ '!*.lock'\
  set grepformat=%f:%l:%c:%m
endif





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









"
" flow
"

" we don't want the autofix window on save
let g:flow#enable = 0
let g:flow#autoclose = 1

" Use locally installed flow
" https://github.com/flowtype/vim-flow/issues/24
let local_flow = finddir('node_modules', '.;') . '/.bin/flow'
if matchstr(local_flow, "^\/\\w") == ''
    let local_flow= getcwd() . "/" . local_flow
endif
if executable(local_flow)
  " for vim-flow
  let g:flow#flowpath = local_flow
endif


"
" autocomplete-flow
"

" this is a good idea, but it's really annoying
let g:autocomplete_flow#insert_paren_after_function = 0











"
" Neocomplete/Deoplete
"

" Enable deoplete when InsertEnter.
if !has('nvim')
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
  inoremap <expr><C-y>     neocomplete#complete_common_string()

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
else
  " turn it on, but do it async so we don't slow things down
  let g:deoplete#enable_at_startup = 0
  autocmd InsertEnter * call deoplete#enable()


  " reduce the delay from the default of 50
  let g:deoplete#auto_complete_delay = 10
  " reduce from the default of 500
  let g:deoplete#auto_refresh_delay = 200

  " Define dictionary.
  let g:deoplete#sources#dictionary#dictionaries = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'scheme' : $HOME.'/.gosh_completions'
          \ }

endif

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
" <C-h>, <BS>: close popup and delete backword char. (for multiple-cursors)
if has('nvim')
  function! g:Multiple_cursors_before()
    let g:deoplete#disable_auto_complete = 1
    let b:deoplete_disable_auto_complete = 1
  endfunction
  function! g:Multiple_cursors_after()
    let g:deoplete#disable_auto_complete = 0
    let b:deoplete_disable_auto_complete = 0
  endfunction
  " inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
  " inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"
else
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
  " inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  " inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
endif
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"


" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" this is too much junk, too many bad results
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags




" neosnippet
let g:neosnippet#enable_completed_snippet = 1
" set the snippets dir
let g:neosnippet#snippets_directory = '~/.vim/snippets'
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-l>     <Plug>(neosnippet_expand_or_jump)
smap <C-l>     <Plug>(neosnippet_expand_or_jump)
xmap <C-l>     <Plug>(neosnippet_expand_target)






" goldfeld/vim-seek
let g:SeekKey = 't'
let g:SeekBackKey = 'T'




" goyo
let g:goyo_height=100
let g:goyo_linenr = 1

function! s:goyo_enter()
  " silent !tmux set status off
  " silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  " set noshowmode
  " set noshowcmd
  " set scrolloff=999

  " use hard wrapping to keep everything on the screen. markdown is smart
  " enough to still format correctly
  " but… it fucks with other things. Turning this off for now
  " call pencil#init({'wrap': 'hard"})
  call pencil#init()


  " enable spell checking. Disable languages that I don't use for perf
  setl spell spl=en_us fdl=4 noru nonu nornu
  " an alternative spell command from https://statico.github.io/vim3.html
  " set spell noci nosi noai nolist noshowmode noshowcmd

  set background=light
endfunction

function! s:goyo_leave()
  " silent !tmux set status on
  " silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  " set showmode
  " set showcmd
  " set scrolloff=5

  " turn off pencil
  " call pencil#init({'wrap': 'off'})

  setl nospell

  set background=dark
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

nmap <leader>w :Goyo<CR>







" pencil and lexical

augroup pencil
  autocmd!
  autocmd FileType markdown,mkd,md call s:goyo_enter()
  autocmd FileType text,txt     call s:goyo_enter()
  autocmd Filetype git,gitsendemail,*commit*,*COMMIT*
                            \   call pencil#init({'wrap': 'hard', 'textwidth': 72})
augroup END

" the default is hard
let g:pencil#wrapModeDefault = 'soft'
let g:pencil#conceallevel = 0     " 0=disable, 1=one char, 2=hide char, 3=hide all (def)
let g:pencil#autoformat = 1      " 0=disable, 1=enable (def)
let g:pencil#textwidth = 80
let g:pencil#cursorwrap = 1     " 0=disable, 1=enable (def)
let g:pencil#conceallevel = 0     " 0=disable, 1=one char, 2=hide char, 3=hide all (def)
let g:pencil#concealcursor = 'c'  " n=normal, v=visual, i=insert, c=command (def)
let g:pencil#map#suspend_af = 'K'   " default is no mapping, allows turning off autoformat with Ko
" custom aireline config
let g:airline_section_x = '%{PencilMode()}'
" tell lexial to enable spelling
let g:lexical#spell = 1         " 0=disabled, 1=enabled
" show a list of suggestions with a Keybindings
let g:lexical#spell_key = '<leader>z'




" vim-markdown
let g:vim_markdown_folding_level = 5














" gitgutter
let g:gitgutter_enabled = 1
let g:gitgutter_realtime = 200
let g:gitgutter_eager = 200
" default mappings start with `h` with messes with navigating buffers
let g:gitgutter_map_keys = 0






"
" ale linting
"
let g:ale_sign_error = '▻'
let g:ale_sign_warning = '•'

" ale can really slow things down in big files, so make it check less
" frequently
" can be "insert", "normal", or "always"
" let g:ale_lint_on_text_changed = 'normal'
" don't actually do that unless you have to, always is a better experience
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_delay = 100

" use eslint_d instead of the local eslint for speed!
let g:ale_javascript_eslint_executable = 'eslint_d'
" so that we prefer eslint_d over the local version :\
let g:ale_javascript_eslint_use_global = 1

" setup ale autofixing
let g:ale_fixers = {}
let g:ale_fixers.javascript = [
\ 'eslint',
\ 'prettier',
\ 'standard',
\]
let g:ale_fixers.css = [
\ 'prettier',
\]
let g:ale_ruby_rubocop_options = '--rails'
let g:ale_fixers.ruby = [
\ 'rubocop',
\]
let g:ale_fix_on_save = 1

nmap [S :ALEPreviousWrap<cr>
nmap ]S :ALENextWrap<cr>







" javascript syntax highlighting
" enable flow support
let g:javascript_plugin_flow = 1








"
" Greplace
"

function! GlobalSearchReplace()
  call inputsave()
  let replacement = input('Search: ')
  call inputrestore()
  execute 'grep '.replacement
  execute 'Gqfopen'
endfunction
" enter once to call the function, again to accept the results of grep and go
" to the fix window
nnoremap <Leader>A :call GlobalSearchReplace()<cr><cr>







" expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)






" mutliple-cursors
" allow moving between normal/visual/insert mode with multiple cursors
" https://github.com/terryma/vim-multiple-cursors#gmulti_cursor_exit_from_visual_mode-default-1
let g:multi_cursor_exit_from_insert_mode = 0
let g:multi_cursor_exit_from_visual_mode = 0






" vim-tmux-navigator
"
" Write all buffers before navigating from Vim to tmux pane
let g:tmux_navigator_save_on_switch = 2







" indent-guides
" It would be nice to enable these but they mess with ack.vim when selecting a
" result and searching. It's not worth it.
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_start_level = 5
let g:indent_guides_guide_size = 1
let g:indent_guide_color_change_percent = 5
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'qf']
" use <leader>ig to toggle, this is the default
let g:indent_guides_default_mapping = 0
nmap <silent> <Leader>ig <Plug>IndentGuidesToggle





" vim-go
" https://github.com/fatih/vim-go-tutorial
" auto-add the right import declartion on fmt
let g:go_fmt_command = "goimports"
" don't use the location list, it's harder to close and navigate
let g:go_list_type = "quickfix"



"
" loupe
"
" This is a good idea, but it messes with any typing of `/` in the command
" line, and requires removal before searching for `<<<` which is common when
" resolving git conflicts
let g:LoupeVeryMagic = 0



"
" rooter
"
" if not in a project directory, set the current directory to the current dir
" let g:rooter_change_directory_for_non_project_files = 'current'
" we'll trigger this ourselves on insert leave/enter
let g:rooter_manual_only = 1
" don't echo the dir change
let g:rooter_silent_chdir = 1
" resolve symbolic links
let g:rooter_resolve_links = 1
" only change for the current window
let g:rooter_use_lcd = 1
" set the current directory to the buffer's directory. This makes it easy to
" create new files relative to the current file
" don't use autochdir or it's older version because it messes with project
" search (FZF)
" if exists('+autochdir')
"   set autochdir
" else
"   autocmd BufEnter * silent! lcd %:p:h
" endif
"
" Instead, use a more manual approach only when entering insert mode, which is
" when it's useful to have filename auto completion be relative.
" via https://superuser.com/questions/604122/vim-file-name-completion-relative-to-current-file
"
" Disabled and combined with rooter
" autocmd InsertEnter * let project_cwd = getcwd() | set autochdir
" autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(project_cwd)

autocmd InsertEnter * set autochdir
autocmd InsertLeave * set noautochdir | execute 'Rooter'

















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
if $TERM == "xterm-256color" || $TERM == "screen-256color"
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

