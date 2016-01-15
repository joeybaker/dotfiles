#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Joey Baker <joey@byjoeybaker.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# set a high ulimit because the OS can handle it an node file watching processes
# are hungry
ulimit -n 10000

# This bunch of code displays red dots when autocompleting
expand-or-complete-with-dots() {
  # a command with the tab key, "Oh-my-zsh"-style.
  echo -n "\e[31m......\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

# Customize to your needs...

# set the default user
export DEFAULT_USER=joeybaker

# 256 colors
if [ -e /usr/share/terminfo/x/xterm-256color ]; then
  export TERM='xterm-256color'
else
  export TERM='xterm-color'
fi

# aliases
alias tolf="find . -type f -not -iname '*.png' -not -iname '*.jpg' -not -iname '*.jpeg' -not -iname '*.gif' -not -iname '*.tif' -not -iname '*.tiff' -not -iname '.git' -exec perl -pi -e 's/\r\n?/\n/g' {} \;"
alias mysql='mysql -u root -proot'
alias sshj='ssh joeybaker@byjoeybaker.com'
alias bower='noglob bower'

alias l='ls -AG'
function mkcd() { mkdir -p "$@" && cd "$_"; }
alias gitp='git pull --rebase --prune && git bclean && test $(git --no-pager log --oneline -n1 origin/master..HEAD | cut -d" " -f1) && git push && git push --tags --no-verify;'
alias gitb='git branch'
alias gitbd='git branch -D'
alias gitcleanup='git fsck —unreachable;
git reflog expire —expire=0 —all;
git repack -a -d -l;
git prune;
git gc —aggressive;'
alias gitcleanremote='git branch -r --merged | grep -v master | sed 's/origin\///' | xargs -n 1 git push --delete origin'
alias git status='git status -sb'
alias html2text='python /Users/joeybaker/scripts/html2text/html2text.py '
function findin(){ find ./ -type f -exec grep -Hn "$1" {} \;;}
alias httpserve="python -m SimpleHTTPServer"
alias pgstart='postgres -D /usr/local/var/postgres'
alias pgstop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
alias couchstop='launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.couchdb.plist'
alias couchstart='launchctl load ~/Library/LaunchAgents/homebrew.mxcl.couchdb.plist'

# sshrc
# alias ssh=sshrc

# git aliases
alias gc="git commit -a"
alias gx="git checkout"
alias gs='git stash'
alias gsp='git stash pop'
alias gsl='git stash list'

# tmux
alias tmux-embed="unset TMUX && tmux"

# I think these were for oh-my-zsh only
# bindkey '\e[A' history-substring-search-up
# bindkey '\e[B' history-substring-search-down

# Customize to your needs...
## default
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH
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
# misc env vars
[[ -s "$HOME/.env" ]] && source "$HOME/.env"

#
# Load stuff in
#

# load rbenv
eval "$(rbenv init -)"
# z
source `brew --prefix`/etc/profile.d/z.sh
# npm
. <(npm completion)

# update function for zprezto
function update_zprezto() {
  cd ~/.zprezto
  git pull --rebase origin master && git submodule update --init --recursive
  git pull --rebase upstream master && git submodule update --init --recursive
  cd -
}

# setup iterm for 256 colors for the oceanic-next theme
# https://github.com/mhartington/oceanic-next-shell
# if [ -f "$HOME/.config/oceanic-next-shell/oceanic-next.dark.sh" ]; then
#  BASE16_SHELL="$HOME/.config/oceanic-next-shell/oceanic-next.dark.sh"
#  [[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
# fi
