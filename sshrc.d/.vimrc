" set to 256 colors
if $TERM == "xterm-256color"
  set t_Co=256
endif
" set color scheme
set background=dark
" add line numbers
set number
" syntax highlighting
syntax on
set hlsearch
set incsearch
set ignorecase
set history=100
set cursorline
set shiftwidth=2
set tabstop=2
set softtabstop=2
set fileformat=unix
set fileformat=unix     " No crazy CR/LF
set nojoinspaces        " One space after a "." rather than 2
set ruler               " Show the line position at the bottom of the window
set showmatch           " Show parentheses matching
set whichwrap=<,>,[,],h,l " Allows for left/right keys to wrap across lines
set writebackup         " Write temporary backup files in case we crash
