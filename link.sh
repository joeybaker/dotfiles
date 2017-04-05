#!/bin/bash
# strict mode http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# stolen from: http://www.splitbrain.org/blog/2011-02/16-managing_dotfiles_with_dropbox

function link () {
  cd $(dirname $0)

  local F=$(pwd | sed -e "s#$HOME/\?##")

  for P in *
  do
    # skip files
    if [ "$P" = "link.sh" ]; then continue; fi
    if [ "$P" = "readme.md" ]; then continue; fi
    if [ "$P" = "hosts" ]; then continue; fi
    if [ "$P" = "appify" ]; then continue; fi
    if [ "$P" = "osx" ]; then continue; fi

    # ensure permissions
    chmod -R o-rwx,g-rwx $P

    # skip existing links
    if [ -h "$HOME/.$P" ]; then continue; fi

    # move existing dir out of the way
    if [ -e "$HOME/.$P" ]; then
      if [ -e "$HOME/__$P" ]; then
        echo "want to override $HOME/.$P but backup exists"
        continue;
      fi

      echo -n "Backup "
      mv -v "$HOME/.$P" "$HOME/__$P"
    fi

    # create link
    echo -n "Link "
    ln -v -s "$F/$P" "$HOME/.$P"

    # Hook up some dotfiles for git
    # via http://codeinthehole.com/writing/a-useful-template-for-commit-messages/
    git config --global commit.template ~/.git_commit_msg.txt
  done
}
link $@
