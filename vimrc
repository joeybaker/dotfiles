scriptencoding utf-8
" sections via: http://dougblack.io/words/a-good-vimrc.html

" auto-install plug if needed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  augroup vimPlug
    autocmd!
    autocmd VimEnter * PlugInstall | source $MYVIMRC
  augroup END
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

" remember cursor position and such when opening a file
Plug 'farmergreg/vim-lastplace'

" colorschemes
" molokai color scheme
Plug 'tomasr/molokai'
" This seems to be a better version of oceanic next
Plug 'mhartington/oceanic-next'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'drewtempelmeyer/palenight.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'dracula/vim'


" Keybindings for commenting lines
Plug 'scrooloose/nerdcommenter'

" snippets
" used by coc-snippets
" but these really mess with better coc-autocompletion options; disable
" Plug 'Shougo/neosnippet'
" Plug 'Shougo/neosnippet-snippets'
" More autocompletion sources
Plug 'wellle/tmux-complete.vim'

" seek with two chars instead on one on a single line
Plug 'goldfeld/vim-seek'

" Syntaxes
Plug 'jakar/vim-json', { 'for': 'json' }
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'toyamarinyon/vim-swift', { 'for': 'swift' }
Plug 'mmalecki/vim-node.js', { 'for': [ 'javascript' ] }
Plug 'pangloss/vim-javascript', { 'for': [ 'javascript' ] }
Plug 'maxmellon/vim-jsx-pretty', { 'for': [ 'javascript' ] } "requires pangloss/vim-javascript or othree/yajs.vim
Plug 'HerringtonDarkholme/yats.vim', { 'for': [ 'typescript', 'reacttypescript' ] }
Plug 'avakhov/vim-yaml', { 'for': 'yaml' }
Plug 'tpope/vim-git'
Plug 'tmux-plugins/vim-tmux'
Plug 'jparise/vim-graphql', { 'for': [ 'javascript', 'graphql', 'typescript' ] }
" NOTE: https://github.com/fleischie/vim-styled-components/issues/23 should
" have fixed things, but something is still conflicting with vim-javascript
" which causes all syntax highlighting to be randomly disabled
" Plug 'fleischie/vim-styled-components', { 'for': 'javascript', 'branch': 'main' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }
Plug 'hail2u/vim-css3-syntax', { 'for': [ 'javascript', 'css', 'typescriptreact' ] } " reccomended by vim-styled-components
Plug 'vim-scripts/nginx.vim', { 'for': 'nginx' }
Plug 'udalov/kotlin-vim', { 'for': 'kotlin' }
Plug 'darfink/vim-plist'

" Spellcheck for certain file types
Plug 'reedes/vim-lexical'

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
" Plug 'w0rp/ale'

" expand regions for easier selections
Plug 'terryma/vim-expand-region'

" surround allows using `s` to direct quotes etc
Plug 'tpope/vim-surround'
" makes surround commands repeatable with .
Plug 'tpope/vim-repeat'

" search and replace across project
Plug 'wincent/ferret'

" being able to `:Gblame` is nice
Plug 'tpope/vim-fugitive'

" being able to `:Gbrowse` to github is nice
Plug 'tpope/vim-rhubarb'

" file management commands like :Move
Plug 'tpope/vim-eunuch'

" auto complete brackets, parens, etc
" disabled, it's too buggy to be worth it.
" Plug 'jiangmiao/auto-pairs'

" auto nice `gf` smarts for require calls
Plug 'moll/vim-node', { 'for': [ 'javascript', 'typescript' ] }

" When using :Gblame from vim-fugitive, shows the commit message
Plug 'tommcdo/vim-fugitive-blame-ext'

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

" disabled because it requires ruby support. ick.
" you should probably just use `gx`, but if you need to open multiple urls,
" this is handy
" Plug 'henrik/vim-open-url'

" see all the undo history, mapped to U below
Plug 'mbbill/undotree'

" fzf for fuzzy finding files. It's like ctrl-p but newer
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" better handling of ruby which doesn't use curlies
Plug 'vim-ruby/vim-ruby'

" for a distraction free wirting experience
Plug 'junegunn/goyo.vim', {'for': ['markdown', 'md', 'txt', 'text']}

" easy motion is kinda nice
Plug 'easymotion/vim-easymotion'

" automatic indenting is good
" But this seems to mess up sometimes with Goyo & markdown files. It unsets
" expandtab and sets tabstop=8.
" Plug 'tpope/vim-sleuth'

" automatic ending keyword insertation for ruby, vimscript, C, and a few
" others
Plug 'tpope/vim-endwise'

" auto close xml/html style tags on </
Plug 'joeybaker/closetag.vim'

" easy case conversion
Plug 'tpope/vim-abolish'

" Use vim to query databases. Plays well with vim-rails
Plug 'tpope/vim-db'

" can set the current directory to the project directory
Plug 'airblade/vim-rooter'

" Python rope gives us jump-to-definition in python
" Disable in favor of the python language server
" Plug 'python-mode/python-mode', { 'branch': 'develop', 'for': 'python' }

" Get to recently closed files
Plug 'yegappan/mru'

" better netrw for better file browsing
Plug 'tpope/vim-vinegar'

" autocompletion via language server
" Plug 'autozimu/LanguageClient-neovim', {
"       \ 'branch': 'next',
"       \ 'do': 'bash install.sh',
"       \ }

" Show marks in the sign bar
Plug 'kshenoy/vim-signature'

" color scheme for writing
Plug 'reedes/vim-colors-pencil', {'for': ['markdown', 'md', 'txt', 'text']}

" easy colorscheme changes
Plug 'reedes/vim-thematic'

" colorize color Hex codes
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

" show git commit with keycommand <leader>gm
Plug 'rhysd/git-messenger.vim'

" coc might be better than ale or language server?
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'yarn install --frozen-lockfile' }

" Initialize plugin system
call plug#end()







"
" UI CONFIG
"
set number " Turn on Line numbers
set relativenumber " The current line will have the absolute number, but all other lines will be relative
setlocal cursorline " highlight the current line; use local so we can disable easily in markdown/text files
set lazyredraw " redraw only when we need to, should speed up macros and such
set showmatch " Show parentheses matching
set updatetime=250 " as recommended by gitgutter https://github.com/airblade/vim-gitgutter#getting-started
set showcmd " shows the current command to the right below airline
set hidden " don't warn when switching buffers is buffer is unsaved https://stackoverflow.com/questions/2414626/unsaved-buffer-warning-when-switching-files-buffers
" https://jameschambers.co.uk/vim-typescript-slow
set re=0

" link to system clipboard
if has('unnamedplus')
  set clipboard=unnamedplus
elseif has('clipboard')
  set clipboard=unnamed
endif

" leave the backup files prefix with ~ on, but save to /tmp instead of cwd
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" Write temporary backup files in case we crash
set writebackup

" more space for messages
set cmdheight=2

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
" since we're effectively auto-saving, swapfiles are kinda pointless. Just
" turn them off
set noswapfile

" remove delay when leaving insert mode by airline
" https://github.com/vim-airline/vim-airline/wiki/FAQ#there-is-a-pause-when-leaving-insert-mode
set ttimeoutlen=10

" Don't pass messages to |ins-completion-menu|. For vim-coc
set shortmess+=c

" persist undo past leaving a buffer
" https://stackoverflow.com/questions/5969807/how-can-i-retain-vim-undo-history-but-disallow-hiding-modified-buffers
if filewritable(&undodir) == 0 | call mkdir(&undodir, 'p') | endif
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
set suffixesadd+=.ts
set suffixesadd+=.tsx
set path+=$PWD/node_modules

" fix for netrw windows not being closable
" https://github.com/tpope/vim-vinegar/issues/13#issuecomment-315584214
set nohidden
augroup netrw_buf_hidden_fix
  autocmd!

  " Set all non-netrw buffers to bufhidden=hide
  autocmd BufWinEnter *
        \  if &ft != 'netrw'
        \|     set bufhidden=hide
        \| endif
augroup end





"
" SPACING
"

set shiftwidth=2
set tabstop=2 " 2 spaces per tab
set softtabstop=2 " the spaces in a tab when hitting the TAB key
" I think smarttab does this in vim-sensible? But it doesn't do the right
" thing when opening a new buffer
" set expandtab " turn the TAB key into spaces
augroup spacing
  autocmd!
  " even though we want expand tab normally, make files are special
  autocmd FileType make setlocal noexpandtab
  " markdown should use spaces to be as simple as possible (prettier also
  " needs this)
  autocmd FileType md,markdown setlocal expandtab
  " empty buffers can't rely on smarttab because it will default to a tab char
  autocmd BufNewFile * setlocal expandtab
augroup END
set fileformat=unix     " No crazy CR/LF
set nojoinspaces        " One space after a "." rather than 2




"
" CUSTOM MAPPING
"

" keep visual mode on after indentation
vnoremap < <gv
vnoremap > >gv

" map leader key
let mapleader=','

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nnoremap <leader>bn :enew<cr>

" Move to the next buffer
nnoremap <silent> <leader>l :bnext!<CR>

" Move to the previous buffer
nnoremap <silent> <leader>h :bprevious!<CR>

" Close all buffers
nnoremap <silent> <leader>bc :silent! bdelete! <c-a><CR><CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
function! BufferDelete()
  if &modified
    echohl ErrorMsg
    echomsg 'No write since last change. Not closing buffer.'
    echohl NONE
  else
    let l:closing_filetype = &filetype

    " if we're in a split, just close the split
    " https://stackoverflow.com/questions/4198503/number-of-windows-in-vim#4198963
    " But, fugitive :Gstatus is special. We want to actually close the buffer
    " so we don't leave it around
    if winnr() > 1 && l:closing_filetype !=? 'fugitive'
      echomsg 'closing' . l:closing_filetype
      close
      return
    endif

    let l:total_nr_buffers = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
    let l:is_split = winnr() > 1
    let l:is_vertical_split = winlayout()[0] == 'row'

    if l:is_vertical_split
      silent! bprevious!
    elseif l:total_nr_buffers == 1
      silent! bdelete!
      echomsg 'Buffer deleted. Created new buffer.'
    else
      silent! bdelete!
      " in vim, we need to go to the previous buffer. This doesn't appear to
      " be necessary in nvim
      if !has('nvim')
        silent! bprevious!
      endif

      " for some reason git gutter doesn't refresh when closing fugitive;
      " force it.
      if l:closing_filetype ==? 'fugitive' && exists('#gitgutter')
        execute 'GitGutter'
      else
        " we don't need to announce this when closing fugitive
        echomsg 'Buffer deleted.'
      endif
    endif
  endif
endfunction

nnoremap <silent> <leader>q :call BufferDelete()<CR>

function! SaveTempBuffer()
  if &modified && @% ==# ''
    " save without letting vim know
    " execute '%!tee '.$PWD.'/tmp-'.bufnr('%').'.vim'
    " set a file name so that vim won't complain when we try to exit with temp
    " buffers. NOTE: this does mean that the above line fanciness isn't really
    " needed.
    execute 'file tmp-'.bufnr('%').'.txt'
  endif
endfunction

augroup savetempbuffer
  autocmd!
  autocmd BufLeave,FocusLost,VimLeavePre * silent! call SaveTempBuffer()
augroup END

" restrict commands to a filetype
" https://stackoverflow.com/a/20105502

" only enable language server setup if it's enabled for the filetype
" else, fallback to ALE and specific overrides
" https://github.com/autozimu/LanguageClient-neovim/blob/next/doc/LanguageClient.txt
function! LC_maps()
  " use ale for default jump to definition
  " other filetypes can override
  " let's use language server for jump to def. It's the future, and ALE can be
  " kinda slow
  if has_key(g:LanguageClient_serverCommands, &filetype)
    nmap <silent> <leader>j  :call LanguageClient#textDocument_definition()<CR>
  else
    nmap <silent> <leader>j :ALEGoToDefinition<CR>
    " use flow for jump to definition
    " ALEGoToDefinition isn't nearly as accurate ← trying again
    " autocmd FileType javascript nmap <silent> <leader>j :FlowJumpToDef<CR>
    " autocmd FileType javascript.jsx nmap <silent> <leader>j :FlowJumpToDef<CR>
    " use rubyjump.vim for jump to definition
    augroup goToDefinition
      autocmd!
      autocmd FileType ruby nmap <silent> <leader>j <Plug>(rubyjump_cursor)
      " use vim-go in go
      autocmd FileType go nmap <silent> <leader>j <Plug>(go-def)
    augroup END
  endif

  " get type under cursor
  " Default to ALE
  " Disable ALE and try LSP, it's built for this.
  if has_key(g:LanguageClient_serverCommands, &filetype)
    nmap <silent> <leader>t   :call LanguageClient#textDocument_hover()<CR>
  else
    " nmap <silent> <leader>t :ALEHover<CR>
    " ALEHover is really slow ← trying again
    " autocmd FileType javascript nmap <silent> <leader>t :FlowType<CR>
    " autocmd FileType javascript.jsx nmap <silent> <leader>t :FlowType<CR>
    " get type under cursor
    augroup getType
      autocmd!
      autocmd FileType go nmap <silent> <leader>t <Plug>(go-info)
    augroup END
  endif

  if has_key(g:LanguageClient_serverCommands, &filetype)
    " language server renaming. This seems risky, but let's try it.
    " https://github.com/autozimu/LanguageClient-neovim/blob/9a8eb0a1ea20263ba1b6819c026c1b728bc25463/doc/LanguageClient.txt#L403-L416
    " Rename - rn => rename
    " noremap <silent> <leader>rr :call LanguageClient#textDocument_rename()<CR>

    " Rename - rc => rename camelCase
    noremap <leader>rc :call LanguageClient#textDocument_rename(
          \ {'newName': Abolish.camelcase(expand('<cword>'))})<CR>

    " Rename - rs => rename snake_case
    noremap <leader>rs :call LanguageClient#textDocument_rename(
          \ {'newName': Abolish.snakecase(expand('<cword>'))})<CR>

    " Rename - ru => rename UPPERCASE
    noremap <leader>ru :call LanguageClient#textDocument_rename(
          \ {'newName': Abolish.uppercase(expand('<cword>'))})<CR>

    " `gq` will use language server if it can
    " don't use this, it doesn't allow comments to auto-break which is the
    " thing I do most.
    " set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()

    " instead of using `*` and `#` to jump to next word under cursor, use LC
    " to actually move between references.
    " eh… this is pretty jank. For instance, in a class, it only finds
    " references for `thing` of `this.props.thing` inside a method and not the
    " whole class.
    noremap <leader>rn :call LanguageClient#textDocument_references()<CR>
  else
    noremap <silent> <leader>rr :ALERename<CR>
  endif
endfunction
augroup lc_config
  autocmd!
  " autocmd FileType * call LC_maps()
augroup END


" disabled because we have ALEFix on save on
" Autofix entire buffer with eslint_d:
" https://www.npmjs.com/package/eslint_d#automatic-fixing
" autocmd FileType javascript nnoremap <leader>f mF:%!eslint_d --cache --stdin --fix-to-stdout<CR>`F
" Autofix entire buffer with python for JSON
" requires `json` to be installed
" `yarn global add json`
" https://github.com/trentm/json
" autocmd FileType json nnoremap <leader>f mF:%!json<CR>`F

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
nnoremap <silent> <leader>d "_d
vnoremap <silent> <leader>d "_d
" Quick yanking to the end of the line
noremap Y y$

" undotree
nnoremap U :UndotreeToggle<cr>

" some niceties for splits. Inspired by: https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
nnoremap <silent> <leader>= :exe "resize +10"<CR>
nnoremap <silent> <leader>- :exe "resize -10"<CR>
nnoremap <silent> <leader>+ <C-W>_
nnoremap <silent> <leader>_ <C-W>|

" preview in marked for markdown
augroup preview_markdown
  autocmd!
  autocmd FileType markdown nmap <silent> <leader>o :!open "%:p" -a Marked\ 2<CR><CR>
augroup END





"
" STARTUP FUNCTIONS
"

" cursor change for tmux
" allows cursor change in tmux mode
if has('nvim')
  :set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor,a:blinkon0
  " restore cursor on vim exit
  augroup tmuxCursor
    autocmd!
    autocmd VimLeave * set guicursor=a:block-blinkon0
  augroup END
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
  return ''
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()






"
" AUTOGROUPS
"

" turn on spell check in git commit messages
augroup git
  autocmd!
  autocmd Filetype gitcommit setlocal spell textwidth=72
augroup END

" save on focus lost, ignore buffers that have never been written
" http://vim.wikia.com/wiki/Auto_save_files_when_focus_is_lost
augroup autoSave
  autocmd!
  autocmd FocusLost * silent! wa
augroup END


augroup customSyntax
  autocmd!
  " setup the custom nginx syntax
  au BufRead,BufNewFile */nginx/*.conf if &ft == '' | setfiletype nginx | endif
  " recognize styl files
  au BufRead,BufNewFile *.styl if &ft == '' | setfiletype css | endif
  " in css, words can contain dashes
  autocmd FileType css setl iskeyword+=-
augroup END






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

" using fzf to find/switch buffers seems better
let g:airline#extensions#tabline#enabled = 0
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
      \'z'    : '#H',
      \}


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
" visible in another window
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

" Show obsession status
let g:airline#extensions#obsession#enabled = 1
" show ale errors
let g:airline#extensions#ale#enabled = 1

" This always displays, skip it and only show file encoding when it's weird
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'







" fzf
" https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2
let g:fzf_command_prefix = 'Fzf'

" https://github.com/junegunn/fzf/blob/master/README-VIM.md
let g:fzf_layout = { 'down': '40%' }

" map this just like ctrl-p
nnoremap <silent> <leader>p :FzfFiles<CR>
nnoremap <silent> <c-p> :FzfFiles<CR>
nnoremap <silent> <tab> :FzfBuffers<CR>

nnoremap <silent> <leader>a :FzfRg<CR>
" enable searching the word under the cursor
nnoremap <silent> <leader>wa :FzfRg <C-R><C-W><CR>


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

" hide the status line while using fzf, it's just unecessary
augroup FZF
  autocmd! FileType fzf
  autocmd FileType fzf let b:current_laststatus=&laststatus
  autocmd FileType fzf setlocal laststatus=0 noshowmode noruler
        \| autocmd BufLeave <buffer> execute "setlocal laststatus=".b:current_laststatus." showmode ruler"
augroup END

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




















" Enable omni completion.
augroup omnicomplete
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  " this is too much junk, too many bad results
  " autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup END









" goldfeld/vim-seek
let g:SeekKey = 't'
let g:SeekBackKey = 'T'




" goyo
let g:goyo_height=100
let g:goyo_linenr = 1

" TODO: better restore of settings when leaving Goyo
function! s:goyo_enter()
  silent echom 'Entering Goyo'

  " Fix for airline re-asserting itself https://github.com/junegunn/goyo.vim/issues/198
  set eventignore=FocusGained

  " silent !tmux set status off
  " silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  setl noshowmode
  setl noshowcmd
  " setl scrolloff=999

  " goyo seems to toggle syntax, make sure it's on
  setl syntax=on
  " goyo seems to toggle background color; reset
  call SetBackground()
endfunction

function! s:goyo_leave()
  silent echom 'Leaving Goyo'
  " silent !tmux set status on
  " silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  setl showmode
  setl showcmd
  " set scrolloff=5

  setl nospell

  " goyo seems to toggle syntax, make sure it's on
  setl syntax=on
  " goyo seems to toggle background color; reset
  call SetBackground()

  " Fix for airline re-asserting itself https://github.com/junegunn/goyo.vim/issues/198
  " this resets to default
  set eventignore=
endfunction

augroup goyo_au
  autocmd!
  autocmd FileType markdown,mkd,md setl syntax=markdown
  autocmd FileType text,txt     setl syntax=text
  autocmd FileType markdown,mkd,md,text,txt call <SID>goyo_enter()

  " enable spell checking. Disable languages that I don't use for perf
  autocmd Filetype markdown,mkd,md,text,txt setlocal spell spl=en_us fdl=4 noru nonu nornu
  " an alternative spell command from https://statico.github.io/vim3.html
  " set spell noci nosi noai nolist noshowmode noshowcmd
  autocmd Filetype markdown,mkd,md,text,txt setlocal linebreak

  autocmd! User GoyoEnter nested call <SID>goyo_enter()
  autocmd! User GoyoLeave nested call <SID>goyo_leave()
augroup END

nnoremap <leader>ww :Goyo<CR>



" vim-markdown
let g:markdown_fenced_languages = ['html', 'bash=sh', 'js=javascript.jsx']














" gitgutter
let g:gitgutter_enabled = 1
let g:gitgutter_realtime = 200
let g:gitgutter_eager = 200
" default mappings start with `h` with messes with navigating buffers
let g:gitgutter_map_keys = 0
nnoremap ]h :GitGutterNextHunk<cr>
nnoremap [h :GitGutterPrevHunk<cr>
nnoremap ghu :GitGutterUndoHunk<cr>
nnoremap ghs :GitGutterStageHunk<cr>





" coc

" navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [; <Plug>(coc-diagnostic-prev)
nmap <silent> ]; <Plug>(coc-diagnostic-next)


" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" rename
nmap <silent> <leader>rr <Plug>(coc-rename)

" Use <C-j> for both expand and jump (make expand higher priority.)
" imap <silent> <C-j> <Plug>(coc-snippets-expand-jump)

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
" if exists('*complete_info')
"   inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" else
"   inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" endif
" use <tab> for trigger completion and navigate to the next complete item
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~ '\s'
" endfunction

" Use <Tab> and <S-Tab> to navigate the completion list:
" https://github.com/neoclide/coc-snippets#examples
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

















"
" languageclient-neovim
"
" Automatically start language servers.
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
      \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
      \ 'python': ['pyls'],
      \ 'sh': ['bash-language-server', 'start'],
      \ 'zsh': ['bash-language-server', 'start']
      \ }
" actually, LSP is way better than ALE for flow.
" disable LC linting; use ALE instead
" https://github.com/autozimu/LanguageClient-neovim/issues/569
let g:LanguageClient_diagnosticsEnable=1








"
" Ferret
"

" disable default mappings; we have our own
let g:FerretMap=0
" allow us to delete files from the quicklist
let g:FerretAcksCommand='cfdo'

" trigger a search; resultss will show it quick list
nmap <leader>A <Plug>(FerretAck)
" or, trigger a search from the word under the cursor
nmap <leader>W <Plug>(FerretAckWord)
" cleanup the quickfix list if necessary by removing instances you don't want,
" then trigger a command to run the replacement
nmap <leader>S <Plug>(FerretAcks)







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
let g:go_fmt_command = 'goimports'
" don't use the location list, it's harder to close and navigate
let g:go_list_type = 'quickfix'



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
let g:rooter_cd_cmd="lcd"
" look at node_modules in addition to the defaults of .git and Rakefile, so
" that we can detect monorepos. This assumes that node_modules will live in
" the project root but files like the Rakefile or requirements.txt will not.
" If that's not a valid assumption… things will be difficult.
" NOTE: order matters. Lower indexies are take priority.
let g:rooter_patterns = [ 'Rakefile', 'requirements.txt', 'node_modules/', '.git', '.git/', '_darcs/', '.hg/', '.bzr/', '.svn/', 'Session.vim' ]
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

augroup rooter
  " TODO: maybe g:LanguageClient_echoProjectRoot is a good idea?
  autocmd!
  autocmd InsertEnter * nested execute 'cd'.expand('%:p:h')
  autocmd InsertLeave,BufAdd,BufEnter * nested call setbufvar('%', 'rootDir', '') | :Rooter
augroup END






"
" Py-mode
"
" Disable the line length warning
let g:pymode_options_colorcolumn = 0
" disable the warnings
let g:pymode_warnings = 1
" Let ALE do linting
let g:pymode_lint = 0
" rope gets us jump-to-definition
let g:pymode_rope = 1
" easy binding
let g:pymode_rope_goto_definition_bind = '<leader>j'
" Syntax is nice?
let g:pymode_syntax = 1













"
" tmux-complete
"
" disable trigger since we have deoplete
let g:tmuxcomplete#trigger = ''















"
" MRU
"
" set the cache to a resonable location
let g:MRU_File = $HOME.'/.vim/mru'

nnoremap <leader><tab> :MRU<cr>


"
" vim-fugitive
"
" easy access to the most common fugitive UI. g for git
nnoremap <leader>g :Git<cr>




"
" vim-colors-pencil
"
let g:pencil_terminal_italics = 1
let g:pencil_higher_contrast_ui = 1   " 0=low (def), 1=high
let g:pencil_spell_undercurl = 1      " 0=underline, 1=undercurl (def)




"
" typescript syntax
"
let g:typescript_indent_disable = 1


"
" oceanic-next
"

let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1


"
" palenight
"
let g:palenight_terminal_italics=1


"
" ayu
"
" let ayucolor="light"  " for light version of theme
let ayucolor='mirage' " for mirage version of theme
" let ayucolor='dark'   " for dark version of theme





"
" hexokinase
"
" to keep default behaviour don't define this variable
let g:Hexokinase_ftEnabled = ['css', 'html', 'javascript', 'reacttypescript']




"
" thematic
"
let g:thematic#themes = {
      \ 'standard'  : {
      \                 'colorscheme': 'ayu',
      \                 'background': 'dark',
      \                 'airline-theme': 'base16_spacemacs',
      \                },
      \ 'write'     : {'colorscheme': 'pencil',
      \                 'background': 'light',
      \                 'airline-theme': 'pencil',
      \                 'laststatus': 0,
      \                 'ruler': 1,
      \                 'font-size': 20,
      \                 'linespace': 8,
      \                 'columns': 80,
      \                },
      \ }

augroup writingMode
  autocmd!
  " disable cursorline in text filetypes because of our theme
  autocmd FileType markdown,md,text,txt setlocal nocursorline
  autocmd FileType * set termguicolors
  " we don't need 24-bit color here, it actually makes the contrast worse
  autocmd BufEnter *
        \  if &ft == 'markdown' || &ft == 'md' || &ft == 'text' || &ft == 'txt'
        \|     set notermguicolors
        \| else
        \|     set termguicolors
        \| endif
  " Fix for airline re-asserting itself https://github.com/junegunn/goyo.vim/issues/198
  " autocmd FileType markdown,md,text,txt setlocal eventignore=FocusGained
  " disable airline
  autocmd FileType markdown,md,text,txt setlocal laststatus=1
augroup end






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

" set background color based on $BACKGROUND env var or in GUI
function! SetBackground()
  if has('gui_running')
    let g:thematic#theme_name = 'write'
    return
  endif

  if exists('$BACKGROUND')
    if $BACKGROUND ==# 'light'
      let g:thematic#theme_name = 'write'
    else
      let g:thematic#theme_name = 'standard'
    endif
  else
    let g:thematic#theme_name = 'standard'
  endif
endfunction



"
" # COLORS
"

if $TERM ==? 'xterm-256color' || $TERM ==? 'screen-256color'
  if has('termguicolors')
    " set 24-bit color
    set termguicolors
  else
    " set to 256 colors
    set t_Co=256
    " in 256 colors, we can't show the colors inline
    execute 'HexokinaseTurnOff'
  endif
endif

" Use color syntax highlighting.
syntax on

" set color scheme
call SetBackground()

