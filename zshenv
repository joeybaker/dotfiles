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
export NODE_PATH=/usr/local/lib/node_modules
# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth
# http://jonisalonen.com/2012/your-bash-prompt-needs-this/
# export PS1="\[\033[G\]$PS1"
# geocouch
export ERL_FLAGS="-pa /usr/local/share/geocouch/ebin"

# set the rack env to dev for ruby (rails)
export RACK_ENV='development'
# set node env
export NODE_ENV='development'

# set the default user
export DEFAULT_USER=joeybaker

# 256 colors
if [ -e /usr/share/terminfo/x/xterm-256color ]; then
  export TERM='xterm-256color'
else
  export TERM='xterm-color'
fi

