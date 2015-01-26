# dotfiles #

Keep your dotfile directory on Dropbox (or whereever). Run `sh link.sh` to symlink your dotfiles to your home directory.

## Full install with zprezto and vundle
  ```bash
  # install zprezto
  # Launch Zsh
  zsh
  # Clone the repository
  git clone --recursive https://github.com/joeybaker/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  # Create a new Zsh configuration by copying the Zsh configuration files provided
  setopt EXTENDED_GLOB
  for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  done
  # set ZSH as default
  chsh -s /bin/zsh
  # install the dot files
  sh link.sh
  # install vundle for vim
  git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle && vim +BundleInstall +qall
  ```
