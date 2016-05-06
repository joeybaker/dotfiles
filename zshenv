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

## default
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH
## add local node_modules so things work like the do in npm https://twitter.com/RReverser/status/720749239224123393
export PATH=./node_modules/.bin:$PATH
## for brew
export PATH=/usr/local/sbin:$PATH
## use brew's GNU utils instead of the built in ones
export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
## for brew's version of PHP
# export PATH="$(brew --prefix josegonzalez/php/php54)/bin:$PATH"
# for rbenv
export PATH=$PATH:~/.rbenv/shims

export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export HOMEBREW_TEMP=~/.homebrew_temp
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

