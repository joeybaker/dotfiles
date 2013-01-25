# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="maran"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias subl='/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl'
alias tolf="find . -type f -not -iname '*.png' -not -iname '*.jpg' -not -iname '*.jpeg' -not -iname '*.gif' -not -iname '*.tif' -not -iname '*.tiff' -not -iname '.git' -exec perl -pi -e 's/\r\n?/\n/g' {} \;"
alias mysql='mysql -u root -proot'
alias sshj='ssh joeybaker@byjoeybaker.com'
alias dal12="ssh -t joey@dal12.meraki.com '(cd /var/www/testweb.meraki.net; /bin/bash;)'"
alias sdg5="ssh -t joey@64.156.192.181 '(cd /var/www/www.meraki.com; /bin/bash;)'"
alias dev100="ssh -A joey@dev100.meraki.com"


alias l='ls -AG'
alias gitp='git pull; git push;'
alias gitcleanup='git fsck —unreachable;
git reflog expire —expire=0 —all;
git repack -a -d -l;
git prune;
git gc —aggressive;'
alias git status='git status -sb'
alias html2text='python /Users/joeybaker/scripts/html2text/html2text.py '
function findin(){ find ./ -type f -exec grep -Hn "$1" {} \;;}
alias deploy="./deploy.sh -u joey"
function whodid(){ git log --pretty=format:"%Cblue%ad %Cgreen%aN %Cred https://github.com/meraki/monty/commit/%H%n%Creset%d%n%B" --date=short --reverse --all --since=2.days.ago $@}
alias httpserve="python -m SimpleHTTPServer"
alias pgstart='postgres -D /usr/local/var/postgres'
alias pgstop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

# set the rack env to dev for ruby (rails)
export RACK_ENV='development'

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git npm github gem sublime rails3 osx heroku brew z)

source $ZSH/oh-my-zsh.sh

# enable vi mode in terminal
bindkey -v

# Customize to your needs...
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/Cellar:$PATH
export PATH="$(brew --prefix josegonzalez/php/php54)/bin:$PATH" # for brew's version of PHP
export PATH="/usr/local/heroku/bin:$PATH" ### Added by the Heroku Toolbelt
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export EDITOR='subl -w'
export HOMEBREW_TEMP=~/.homebrew_temp
export NODE_PATH=/usr/local/lib/node_modules
# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth
# http://jonisalonen.com/2012/your-bash-prompt-needs-this/
# export PS1="\[\033[G\]$PS1"


# Load RVM into a shell session *as a function*
# [[ -s "/Users/joeybaker/.rvm/scripts/rvm" ]] && source "/Users/joeybaker/.rvm/scripts/rvm"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

