# dotfiles

_This might be useful to turn this readme into a script: https://github.com/bkuhlmann/osx/blob/master/README.md_

- sys prefs
  - enable tap to click
  - enable triple hold to move
  - enable four finger swipe down for expose
  - disable launch pad gesture
  - enable filevault
- turn on filevault
- app store for OS updates [restart]
- install [brew](http://brew.sh)

  - [some helpful tips](http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac) (incorporated below)

    ```sh
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    mkdir ~/.homebrew_temp
    brew tap phinze/cask
    brew tap caskroom/versions
    brew tap caskroom/fonts
    	brew tap ValeLint/vale

    # Install command line tools; brew does this for us now
    # xcode-select --install

    # lua is for the neocomplete plugin vim plugin
    brew install vim --override-system-vi --with-python3 --with-lua
    brew install reattach-to-user-namespace z the_silver_searcher ccat node tmux sshrc git zsh ack findutils bash shellcheck httpie jo mas autoenv coreutils cmake gpg rbenv yarn thefuck nvm neovim/neovim/neovim python3 python2 vale fd ripgrep fzf pgcli progress pinentry-mac prettyping tldr bat
    brew install hub --devel # 2.3.0 has been blocked for a year. We want it for PR templates
    # b/c newer is better, and for diff-so-fancy
    brew install gnu-sed grep --with-default-names
    brew cask install gitify google-chrome firefox iterm2 phoenix istat-menus cloudup google-chrome-canary karabiner-elements flux sidestep bartender 1password alfred syncthing spillo vlc atext dash safari-technology-preview gitup keybase pock
    # great quicklook plugins [via](https://github.com/sindresorhus/quick-look-plugins)
    brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv webpquicklook webpquicklook suspicious-package quicklookase qlvideo && qlmanage -r
    # fonts
    # [Source Code Pro](https://github.com/adobe/source-code-pro/downloads)
    # [patched fonts for terminal](https://github.com/Lokaltog/powerline-fonts)
    # [Inconsolata-g](http://leonardo-m.livejournal.com/77079.html)
    brew cask install font-inconsolata font-inconsolata-dz-for-powerline font-sourcecodepro-nerd-font-mono
    brew cleanup
    # viml linter
    pip3 install vim-vint --user
    # install for neovim
    	# NOTE: installing RVM later might mean this will need to be re-installed
    gem install neovim
    # install for deoplete in neovim
    pip3 install neovim
    pip2 install neovim
    pip install diff-highlight
    pip install 'python-language-server[all]'
    ```

- install oceanic-next iTerm theme (the main theme is in the sync folder)

  ```sh
  git clone https://github.com/mhartington/oceanic-next-shell.git ~/.config/oceanic-next-shell
  ```

- follow install instructions for [zprezto](https://github.com/sorin-ionescu/prezto).

  ```bash
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
  ```

- setup 1password
- setup syncthing
- dotfile link
  - NOTE: with symlinks and such, the zsh dotfiles might need to be moved to another location inside the `.zprezto` folder
  - `sh ~/Sync/dotfiles/link.sh "my-computer-name"`
- Install vim plugins
  ```
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  ```
- configure git

  ```sh
  git config --global user.name "Joey Baker"
  git config --global user.email "joey@byjoeybaker.com"
  # use diff-so-fancy
  git config --global core.pager "diff-highlight | diff-so-fancy | less --tabs=1,5 -R"
  git config --global color.diff-highlight.oldNormal "red bold"
  git config --global color.diff-highlight.oldHighlight "red bold 52"
  git config --global color.diff-highlight.newNormal "green bold"
  git config --global color.diff-highlight.newHighlight "green bold 22"
  ```

- Install tmux plugin manager `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
  - start tmux with `tmux`
  - then: `<prefix> <shift-I>`
- `sudo sh ~/sh/osx.sh "my-computer-name"`
- install [nodejs](http://nodejs.org) & relevant global packages

  ```bash
  nvm install stable
  nvm alias default node
  npm whoami # creates the necessary dirs
  # no sudo for global installs!
  sudo chown -R $(whoami) ~/.npm; sudo chown -R $(whoami) /usr/local/lib/node_modules
  brew install yarn --without-node
  yarn global add supervisor nodemon ghwd ghcopy json trash-cli irish-pub localhapi diff-so-fancy concurrently alfred-npms alfred-github bash-language-server
  npm config set init.author.name 'Joey Baker'
  npm config set init.author.email 'joey@byjoeybaker.com'
  npm config set init.author.site 'http://byjoeybaker.com'
  npm config set init.license Artistic-2.0
  npm config set init.version 0.0.0
  npm config set save-prefix "^"
  npm config set save true
  npm config set version true
  # sets the npm cache on an external volume so that we don't trash the builtin ssd
  npm config set cache /Volumes/jbdb/npm
  # authorize ghcopy, will prompt
  ghcopy-authorize
  ```

- [Karabiner](https://github.com/tekezo/Karabiner-Elements) configs in dotfiles. Just open the app and all should be good.
- chrome canary

  - settings > on startup > continue where I left off
  - settings > search > enable instant
  - ![check for certification revocation](http://i.imgur.com/DsB8Oz0.png)
  - vimium options, add to the css:

    ```css
    div.vimiumHUD {
      width: 100vw;
      max-width: 100vw;
      padding: 0.5em 0.5em 0.75em;
      right: 0 !important;
      left: 0 !important;
      border-radius: 0;
      background: rgba(250, 150, 60, 0.9);
      font-size: 14px;
      font-family: "Source Sans Pro", monospace;
      bottom: 0;
    }
    ```

- [sublime text](http://www.sublimetext.com/3)
  - [sublime packages](https://github.com/joeybaker/my_sublime_packages/tree/st3)
  - For better vintage mode in sublimetext `defaults write com.sublimetext.2 ApplePressAndHoldEnabled -bool false && defaults write com.sublimetext.3 ApplePressAndHoldEnabled -bool false`
- [iterm2](http://www.iterm2.com/#/section/home)
  - link to preferences on Sync
  - ensure sourcecode pro powerline font is selected
- [alfred](http://www.alfredapp.com)
  - license in 1P
  - setup sync folder
  - disable spotlight keyboard shortcut
  - change default keyboard shortcut
- app store

  ```sh
  mas install 432764806 #the hit list
  mas install 1107421413 #1blocker
  mas install 1121192229 #Better
  mas install 1384080005 #tweetbot
  mas install 425424353 #The Unarchiver
  mas install 435410196 #stay
  mas install 975937182 #fantastical
  mas install 918858936 #airmail
  ```

  - 1blocker
  - the hit list
    - enable sync from 1P
    - enable global shortcut
    - enable dock badge count
  - atext
    - hide in dock
    - launch on startup
    - setup sync
  - tweetbot
    - account signin
    - cloudapp & instapaper accounts
    - turn on notifications
  - The Unarchiver
  - stay
    - store windows
    - start on login
    - uncheck restore windows as applications are launched
  - fantastical
    - setup pwds for google accounts

- istatmenus
  - register from 1P
  - change theme
  - customize widgets
- system clock
  - 24 time
  - turn on date
  - set custom lang/date prefs for start week on Monday, etc…
- flux
  - start at login
- bartender
  - start at login
  - move select apps inside
- [github notifier](https://github.com/manosim/gitify)
- cloudup: start and login
- syncthing: start and login
- airmail: start and add accounts
- phoenix: start
- d/l and start http://privateinternetaccess.com

- [hosts file](http://someonewhocares.org/hosts/hosts)
  - `sudo curl -sS http://someonewhocares.org/hosts/hosts -o /etc/hosts && dscacheutil -flushcache`
- [sidestep](http://chetansurpur.com/projects/sidestep/)
  - [enable localhost](https://github.com/chetan51/sidestep/issues/32#issuecomment-16606585)
  - Network -> select device -> Advanced -> Proxies -> Bypass proxy settings: add "localhost"
- Chrome:
  - install 1Password extensions
  - ublock extension:
    - enable easy list
    - enable Fanboy's social blocking list (https://monzta.maltekraus.de/adblock_social.txt)
      - enable anything else that looks good
  - set default search to duckduckgo.com
- setup time machine
- [install github ssh keys](https://help.github.com/articles/generating-ssh-keys)

  - Set a secure SSH key: https://blog.g3rt.nl/upgrade-your-ssh-keys.html
  - Set a gpg key for github: https://github.com/pstadler/keybase-gpg-github If you don't use keybase: https://blog.erincall.com/p/signing-your-git-commits-with-gpg

        ```sh
        mkdir -p ~/.gnupg
        echo 'pinentry-program /usr/local/bin/pinentry-mac' > ~/.gnupg/gpg-agent.conf
        echo 'no-tty' >> ~/.gnupg/gpg-agent.conf'
        ```

  - After setting gpg in git, set for npm: `npm config set sign-git-tag true`

- [secure sudo](http://blog.rongarret.info/2015/08/psa-beware-of-sudo-on-os-x.html) ← no longer necessary on sierra
- don't forget to install Adobe things if necessary
- Dash license from 1Password
- increase the system file descriptor limits for dev https://facebook.github.io/watchman/docs/install.html#max-os-file-descriptor-limits

## open-in-vi

Create a new automator app to open files in vi

```applescript
on run {input}
	set filename to POSIX path of input
	set cmd to "clear;cd $(dirname " & filename & ");nvim -c 'Goyo' " & quoted form of filename & "; exit"
	tell application "System Events" to set terminalIsRunning to exists application process "Terminal"
	tell application "Terminal"
		activate
		if terminalIsRunning is true then
			set newWnd to do script with command cmd
      do script with command cmd in newWnd
		else
			do script with command cmd in window 1
		end if
	end tell
end run
```

## Vim setup

- `ctrl-l` with an autocomplete dropdown open will complete a snippet. Press again to skip to the next delimiter
- `leader-h` previous tab
- `leader-l` next tab
- `leader-j` jump to definition in js
- `leader-f` autofix file in js
- `leader-n` clear search highlighting
- `leader-s` save the file (works in insert and normal mode)
- `leader-yf` copy the current file path
- `leader-c<space>` toggle comment
