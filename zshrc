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

export NVM_LAZY_LOAD=true
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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

# aliases
# prefer the brew vim to the system vim
# Actually, replace vim with nvim
if [ -x /usr/local/bin/nvim ]; then
  alias vi='session_file=Session$(echo ${TMUX_PANE-} | sed "s/\%//").vim; [ -f $session_file ] && /usr/local/bin/nvim -S "$session_file" || /usr/local/bin/nvim'
  alias vim=vi
elif [ -x /usr/local/bin/vim ]; then
  alias vi='session_file=Session$(echo ${TMUX_PANE-} | sed "s/\%//").vim; [ -f $session_file ] && /usr/local/bin/vim -S "$session_file" || /usr/local/bin/vim'
  alias vim=vi
fi

alias tolf="find . -type f -not -iname '*.png' -not -iname '*.jpg' -not -iname '*.jpeg' -not -iname '*.gif' -not -iname '*.tif' -not -iname '*.tiff' -not -iname '.git' -exec perl -pi -e 's/\r\n?/\n/g' {} \;"
alias sshj='ssh joeybaker@byjoeybaker.com'

# for `brew install thefuck`
eval "$(thefuck --alias)"

alias l='/bin/ls -AG'
# sleep 0.1 b/c the cleaning script locks git, and we need to wait for that to clear
function mkcd() { mkdir -p "$@" && cd "$_"; }
function gitp () {
git pull --rebase --prune | \
    tee /dev/tty | \
    grep '^ \- \[deleted\]' | \
    awk -F/ '{print $2}' | \
  xargs git branch -D && \
  git bclean && \
  sleep 0.1 && \
  test $(git --no-pager log --oneline -n1 origin/$(git rev-parse --abbrev-ref HEAD)..HEAD | cut -d" " -f1) && \
  git push && \
  git push --tags --no-verify
}
alias gitb='git branch'
alias gitbd='git branch -D'
alias gitx='gitup'
alias gitcleanup='git fsck —unreachable;
git reflog expire —expire=0 —all;
git repack -a -d -l;
git prune;
git gc —aggressive;'
alias gitcleanremote='git branch -r --merged | grep -v master | sed "s/origin\///" | xargs -n 1 git push --delete origin'
alias git status='git status -sb'
alias html2text='python /Users/joeybaker/scripts/html2text/html2text.py '
function findin(){ find ./ -type f -exec grep -Hn "$1" {} \;;}
alias httpserve="python -m SimpleHTTPServer"
alias pgstart='postgres -D /usr/local/var/postgres'
alias pgstop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
alias couchstop='launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.couchdb.plist'
alias couchstart='launchctl load ~/Library/LaunchAgents/homebrew.mxcl.couchdb.plist'
alias guard='bundle exec guard'

function upgrade_all_the_things () {
  vim +PlugUpdate
  yarn global upgrade-interactive
  npm-check -gu
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
  update_zprezto
}

# brew-cask
alias brewcaskup='bash ~/sh/brew-cask-upgrade.sh'

# sshrc
# alias ssh=sshrc

# git aliases
alias gc="git commit -a"
alias gx="git checkout"
alias gs='git stash'
alias gsp='git stash pop'
alias gsl='git stash list'
alias gre='git rebase -i origin/master'

# tmux
alias tmux-embed="unset TMUX && tmux"

# I think these were for oh-my-zsh only
# bindkey '\e[A' history-substring-search-up
# bindkey '\e[B' history-substring-search-down

# easier file creation
# recursively touch, e.g. touch + mkdir -p
# so files can easily be created at depth
# https://coderwall.com/p/ghwp5a/canhaz-recursive-touch-in-shell
mk () {
  mkdir -p -- "${1%/*}" && touch -- "$1"
}

#
# Load stuff in
#

# load rbenv
eval "$(rbenv init -)"
# z
source `brew --prefix`/etc/profile.d/z.sh

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

# npm
# npm install autocomplete https://medium.com/@jamischarles/adding-autocomplete-to-npm-install-5efd3c424067#.sc3eethvx
_npm_install_completion() {
  local si=$IFS

  # if 'install' or 'i ' is one of the subcommands, then...
  if [[ ${words} =~ 'install' ]] || [[ ${words} =~ 'i ' ]]; then

    # add the result of `ls ~/.npm` (npm cache) as completion options
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
      COMP_LINE=$BUFFER \
      COMP_POINT=0 \
      /bin/ls $(cat ~/.npmrc | grep cache= | sed s/cache=//) -- "${words[@]}" \
      2>/dev/null)
  fi

  IFS=$si
}
compdef _npm_install_completion 'npm'

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
[[ -f /Users/joeybaker/server/dotfiles/config/yarn/global/node_modules/tabtab/.completions/yarn.zsh ]] && . /Users/joeybaker/server/dotfiles/config/yarn/global/node_modules/tabtab/.completions/yarn.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# fzf via Homebrew
if [ -e /usr/local/bin/fzf/shell/completion.zsh ]; then
  source /usr/local/bin/fzf/shell/key-bindings.zsh
  source /usr/local/bin/fzf/shell/completion.zsh
fi

