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

# Customize to your needs...

# set the default user
DEFAULT_USER=joeybaker

# 256 colors
# if [ -e /usr/share/terminfo/x/xterm-256color ]; then
  export TERM='screen-256color'
# else
  # export TERM='xterm-color'
# fi
export GPG_TTY=$(tty)


# prefer the brew vim to the system vim
# Actually, replace vim with nvim

function v() {
  if type nvim > /dev/null; then
    cmd=nvim
  elif type vim > /dev/null; then
    cmd=vim
  fi
  if [ $# -eq 0 ]
    then
    session_file=Session$(echo ${TMUX_PANE-} | sed "s/\%//").vim; [ -f $session_file ] && ${cmd} -S "$session_file" || ${cmd}
  else
    ${cmd} $1
  fi
}

alias l='ls -AG'
function mkcd() { mkdir -p "$@" && cd "$_"; }
alias html2text='python /Users/joeybaker/scripts/html2text/html2text.py '
function findin(){ find ./ -type f -exec grep -Hn "$1" {} \;;}
alias httpserve="python -m SimpleHTTPServer"
alias pgstart='postgres -D /usr/local/var/postgres'
alias pgstop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

# git aliases
function gitp () {
git pull --rebase --prune | \
    tee /dev/tty | \
    grep '^ \- \[deleted\]' | \
    awk -F/ '{print $2}' | \
  xargs git branch -D && \
  git bclean && \
  sleep 0.1 && \
  test $(git --no-pager log --oneline -n1 origin/$(git rev-parse --abbrev-ref HEAD)..HEAD | cut -d" " -f1) && \
  git push $* && \
  git push --tags --no-verify
}
alias gitb='git branch'
alias gitbd='git branch -D'
alias gitcleanup='git fsck —unreachable;
git reflog expire —expire=0 —all;
git repack -a -d -l;
git prune;
git gc —aggressive;'
alias git status='git status -sb'
alias gc="git commit -a"
alias gx="git checkout"
alias gs='git stash'
alias gsp='git stash pop'
alias gsl='git stash list'
alias gitcleanremote='git branch -r --merged | grep -v master | sed "s/origin\///" | xargs -n 1 git push --delete origin'

# tmux
alias tmux-embed="unset TMUX && tmux"


function upgrade_all_the_things () {
  nvim +PlugUpdate
  yarn global upgrade-interactive --latest
  command -v npm-check >/dev/null 2>&1 && npm-check -gu || echo "npm-check not installed, skipping npm global dependency updates $(npm ls --depth=0 -g)"
  echo 'Updating brew…'
  brew update && brew outdated
  while true; do
    read "cmd?Run a command (probably brew upgrade) [\"done\" to keep going]: "

    case $cmd in
     [done]* ) echo "Moving on…"
             break;;
     * )     eval $cmd;;
    esac
  done
  mas outdated
  mas upgrade
  update_zprezto && exec zsh
}

function ping() {
  command -v prettyping >/dev/null 2>&1 && prettyping --nolegend $@ || ping $@
}

# I think these were for oh-my-zsh only
# bindkey '\e[A' history-substring-search-up
# bindkey '\e[B' history-substring-search-down

# Customize to your needs...

# This bunch of code displays red dots when autocompleting
expand-or-complete-with-dots() {
  # a command with the tab key, "Oh-my-zsh"-style.
  echo -n "\e[31m......\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

## default
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH
## for brew
export PATH=/opt/homebrew/bin:$PATH
# for rbenv
export PATH=$PATH:~/.rbenv/shims
export PATH=$PATH:./node_modules/.bin

export EDITOR='vi'
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
source /opt/homebrew/etc/profile.d/z.sh

# for `brew install thefuck`
eval "$(thefuck --alias)"


#zmv
autoload zmv
# easier access to online help
# unalias run-help
autoload run-helpd
HELPDIR=/usr/local/share/zsh/helpfiles

# easier file creation
# recursively touch, e.g. touch + mkdir -p
# so files can easily be created at depth
# https://coderwall.com/p/ghwp5a/canhaz-recursive-touch-in-shell
mk () {
  mkdir -p -- "${1%/*}" && touch -- "$1"
}


# update function for zprezto
function update_zprezto() {
  cwd=$(pwd)
  cd ~/.zprezto
  git submodule update --init --recursive
  git pull --rebase origin master && git submodule update --recursive --remote
  git pull --rebase upstream master && git submodule update --recursive --remote
  cd $cwd
}

###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# tabtab source for yarn package
# uninstall by removing these lines or running `tabtab uninstall yarn`
[[ -f /Users/joeybaker/dotfiles/config/yarn/global/node_modules/tabtab/.completions/yarn.zsh ]] && . /Users/joeybaker/dotfiles/config/yarn/global/node_modules/tabtab/.completions/yarn.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fzf via Homebrew
if [ -e /usr/local/bin/fzf/shell/completion.zsh ]; then
  source /usr/local/bin/fzf/shell/key-bindings.zsh
  source /usr/local/bin/fzf/shell/completion.zsh
fi

