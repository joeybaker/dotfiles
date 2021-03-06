#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

## manpath
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# export HOMEBREW_CASK_OPTS="--appdir=/Applications"
# export HOMEBREW_TEMP=~/.homebrew_temp
# disable homebrew analytics b/c privacy
export HOMEBREW_NO_ANALYTICS=1
# disable this, nvm should set it?
# export NODE_PATH=/usr/local/lib/node_modules
export NODE_PATH=$NVM_BIN/../lib/node_modules/
# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth
# http://jonisalonen.com/2012/your-bash-prompt-needs-this/
# export PS1="\[\033[G\]$PS1"
# via https://github.com/golang/go/wiki/GOPATH
export GOPATH="$HOME/server/go"
# for virtualenvwrapper
export PROJECT_HOME="$HOME/server"

# set the rack env to dev for ruby (rails)
export RACK_ENV='development'
# set node env
export NODE_ENV='development'

# set the default user
export DEFAULT_USER=joeybaker

# This doesn't appear to work on macOS, just assume 256 color
# 256 colors
# if [ -e /usr/share/terminfo/x/xterm-256color ]; then
#   export TERM='xterm-256color'
# else
#   export TERM='xterm-color'
# fi
#
# nvim wants screen-256color: `nvim +CheckHealth`
export TERM='screen-256color'


# http://owen.cymru/fzf-ripgrep-navigate-with-bash-faster-than-ever-before/
# https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!**/{.git,vendor,dist,.cache,__snapshots__,coverage,tmp}/*" --glob "!*.lock"'
# I'm not sure this is necessary, but several docs say it is? https://statico.github.io/vim3.html
# vim seems to break when I enable it.
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

if [ -f "$HOME/.config/.env" ]; then
  source "$HOME/.config/.env"
fi
