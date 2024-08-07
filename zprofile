#
# Executes commands at login pre-zshrc.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

#
# Browser
#

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

#
# Editors
#

export EDITOR='vi'
export VISUAL='vi'
export PAGER='less'

#
# Language
#

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set the list of directories that Zsh searches for programs.
path=(
  # add local node_modules so things work like the do in npm https://twitter.com/RReverser/status/720749239224123393
  ./node_modules/.bin
  /usr/local/{bin,sbin}
  ## for yarn
  $HOME/.config/yarn/global/node_modules/.bin
  ## use brew's GNU utils instead of the built in ones
  ## This has to be last so that the gnu utils override all else
  /usr/local/opt/coreutils/libexec/gnubin
  # use brew openssl
  /usr/local/opt/openssl/bin
  $path
  # for rbenv
  $HOME/.rbenv/shims
  # for go
  ${GOPATH//://bin:}/bin
  ## python3
  $HOME/Library/Python/3.7/bin
  # for rust
  $HOME/.cargo/bin
)

# autoenv
# FIXME: this is soo slow to load!
# source $(brew --prefix autoenv)/activate.sh
eval "$(/opt/homebrew/bin/brew shellenv)"

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

#
# Temporary Files
#

if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$USER"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"
if [[ ! -d "$TMPPREFIX" ]]; then
  mkdir -p "$TMPPREFIX"
fi

#
# GPG
#
# https://stackoverflow.com/questions/51504367/gpg-agent-forwarding-inappropriate-ioctl-for-device
export GPG_TTY=$(tty)
