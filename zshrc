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

# npm
. <(npm completion)
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

# set the default user
export DEFAULT_USER=joeybaker

# 256 colors
if [ -e /usr/share/terminfo/x/xterm-256color ]; then
  export TERM='xterm-256color'
else
  export TERM='xterm-color'
fi

# aliases
# prefer the brew vim to the system vim
  if [ -x /usr/bin/local/vim ]; then
    alias vim='/usr/bin/local/vim'
    alias vi='/usr/bin/local/vim'
  fi
alias tolf="find . -type f -not -iname '*.png' -not -iname '*.jpg' -not -iname '*.jpeg' -not -iname '*.gif' -not -iname '*.tif' -not -iname '*.tiff' -not -iname '.git' -exec perl -pi -e 's/\r\n?/\n/g' {} \;"
alias mysql='mysql -u root -proot'
alias sshj='ssh joeybaker@byjoeybaker.com'

alias l='/bin/ls -AG'
# sleep 0.1 b/c the cleaning script locks git, and we need to wait for that to clear
function mkcd() { mkdir -p "$@" && cd "$_"; }
alias gitp='git pull --rebase --prune && git bclean && sleep 0.1 && test $(git --no-pager log --oneline -n1 origin/master..HEAD | cut -d" " -f1) && git push && git push --tags --no-verify;'
alias gitb='git branch'
alias gitbd='git branch -D'
alias gitx='gitup'
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

# tmux
alias tmux-embed="unset TMUX && tmux"

# I think these were for oh-my-zsh only
# bindkey '\e[A' history-substring-search-up
# bindkey '\e[B' history-substring-search-down

#
# Load stuff in
#

# load rbenv
# eval "$(rbenv init -)"
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
