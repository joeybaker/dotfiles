# dotfiles #

_This might be useful to turn this readme into a script: https://github.com/bkuhlmann/osx/blob/master/README.md_

* sys prefs
    * enable tap to click
    * enable triple hold to move
    * enable four finger swipe down for expose
    * disable launch pad gesture
    * enable filevault
* turn on filevault
* app store for OS updates [restart]
* install [brew](http://brew.sh)
    * [some helpful tips](http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac) (incorporated below)

        ```bash
        ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
        mkdir ~/.homebrew_temp
        brew tap homebrew/dupes
        brew tap phinze/cask
        brew tap caskroom/versions
        brew tap caskroom/fonts

        # Install command line tools
        xcode-select --install

        # cmake is for youcompleteme a vim plugin
        brew install vim --override-system-vi
        brew install reattach-to-user-namespace z the_silver_searcher ccat node tmux sshrc git zsh ack findutils bash shellcheck homebrew/dupes/grep httpie jo mas autoenv coreutils cmake
        cd ~/.vim/bundle/YouCompleteMe
        ./install.py --tern-completer
        # b/c newer is better, and for diff-so-fancy
        brew install gnu-sed --with-default-names
        brew cask install gitify google-chrome firefox iterm2 adium slate istat-menus airmail cloudup sublime-text google-chrome-canary karabiner-elements  flux sidestep bartender 1password alfred syncthing vlc spillo atext rocket dash
        brew cask alfred link
        # great quicklook plugins [via](https://github.com/sindresorhus/quick-look-plugins)
        brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql webp-quicklook qlImageSize webpquicklook suspicious-package qlmarkdown && qlmanage -r
        # fonts
        # [Source Code Pro](https://github.com/adobe/source-code-pro/downloads)
        # [patched fonts for terminal](https://github.com/Lokaltog/powerline-fonts)
        # [Inconsolata-g](http://leonardo-m.livejournal.com/77079.html)
        brew cask install font-inconsolata font-inconsolata-dz-for-powerline font-source-code-pro font-sauce-code-powerline
        brew cleanup
        ```

* install oceanic-next iterm theme (the main theme is in the sync folder)

    ```sh
    git clone https://github.com/mhartington/oceanic-next-shell.git ~/.config/oceanic-next-shell
    ```

* follow install instructions for [zprezto](https://github.com/sorin-ionescu/prezto).

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

* setup syncthing
* dotfile link
    * NOTE: with symlinks and such, the zsh dotfiles might need to be moved to another location inside the `.zprezto` folder
    * `sh ~/Sync/dotfiles/link.sh "my-computer-name"`
* `git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/Vundle.vim && vim +PluginInstall +qall`
* configure git

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

* Install tmux plugin manager `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
    * start tmux with `tmux attach`
    * then: `<prefix> <ctrl-I>`
* `sudo sh ~/sh/osx.sh "my-computer-name"`
* install [nodejs](http://nodejs.org) & relevant global packages

    ```bash
    # no sudo for global installs!
    sudo chown -R $(whoami) ~/.npm; sudo chown -R $(whoami) /usr/local/lib/node_modules
    npm i -g nave supervisor nodemon npm-check ghwd ghcopy json trash-cli irish-pub localhapi diff-so-fancy
    nave usemain stable
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

* Karabiner-elements and hammerspoon; copy configs
* ~[Karabiner](http://pqrs.org/macosx/karabiner/)~ *THIS NO LONGER WORKS ON SIERRA, KEEPING IT UNTIL WE GET FULL FUNCTIONALITY BACK. SEE KARABINER-ELEMENTS AND HAMMERSPOON*
  * copy private.xml

    ```
      mkdir -p ~/Library/Application\ Support/Karabiner && ln -s ~/Sync/dotfiles/private.xml ~/Library/Application\ Support/Karabiner/private.xml
    ```

    * simultaneous Vi mode > simultaneous key presses [S+D] turns on “sim…
    * simultaneous Vi mode > change [] to backward-word…
    * shifts to parenteses
    * use correct shift keys
    * f19 to escape/hyper
    * turn off menubar
    * Key Repeat > Key Overlaid Modifier > Timeout: 200
* ~[seil](http://pqrs.org/macosx/Karabiner/seil.html.en)~
    * caps lock to f19 (key code: 80)
    * be sure to disable caps lock in keyboard settings
    * better instructions: https://github.com/jasonrudolph/keyboard
* chrome canary
    * settings > content settings > plugins > click to play
    * settings > on startup > continue where I left off
    * settings > search > enable instant
    * [check for certification revocation](http://i.imgur.com/DsB8Oz0.png)
    * vimium options, add to the css:

        ```css
        div.vimiumHUD {
            width: 100vw;
            max-width: 100vw;
            padding: .5em .5em .75em;
            right: 0 !important;
            left: 0 !important;
            border-radius: 0;
            background: rgba(250, 150, 60, .9);
            font-size: 14px;
            font-family: 'Source Sans Pro', monospace;
            bottom: 0;
        }
        ```

* [sublime text](http://www.sublimetext.com/3)
    * [sublime packages](https://github.com/joeybaker/my_sublime_packages/tree/st3)
    * For better vintage mode in sublimetext `defaults write com.sublimetext.2 ApplePressAndHoldEnabled -bool false && defaults write com.sublimetext.3 ApplePressAndHoldEnabled -bool false`
* [iterm2](http://www.iterm2.com/#/section/home)
    * link to preferences on Sync
* [alfred](http://www.alfredapp.com)
    * license in 1P
    * setup sync folder
    * disable spotlight keyboard shortcut
    * change default keyboard shortcut
* app store

    ```sh
    mas install 432764806 #the hit list
    mas install 1107421413 #1blocker
    mas install 557168941 #tweetbot
    mas install 425424353 #The Unarchiver
    mas install 435410196 #stay
    mas install 975937182 #fantastical
    ```

    * 1blocker
    * the hit list
        * enable sync from 1P
        * enable global shortcut
        * enable dock badge count
    * atext
        * hide in dock
        * launch on startup
        * setup sync
    * tweetbot
        * account signin
        * cloudapp & instapaper accounts
        * turn on notifications
    * The Unarchiver
    * stay
        * store windows
        * start on login
        * uncheck restore windows as applications are launched
    * fantastical
        * setup pwds for google accounts
* istatmenus
    * register from 1P
    * change theme
    * customize widgets
* system clock
    * 24 time
    * turn on date
    * set custom lang/date prefs for start week on Monday, etc…
* flux
    * start at login
* bartender
    * start at login
    * move select apps inside
* [github notifier](https://github.com/manosim/gitify)

* [hosts file](http://someonewhocares.org/hosts/hosts)
    * `sudo rm /etc/hosts && sudo cp ~/Sync/dotfiles/hosts /etc/hosts && sudo chmod 644 /etc/hosts && dscacheutil -flushcache`
* [sidestep](http://chetansurpur.com/projects/sidestep/)
    * [enable localhost](https://github.com/chetan51/sidestep/issues/32#issuecomment-16606585)
    * Network -> select device -> Advanced -> Proxies -> Bypass proxy settings: add "localhost"
* Chrome:
    * install 1Password extensions
    * ublock extension:
        * enable easy list
        * add: https://monzta.maltekraus.de/adblock_social.txt
* setup time machine
* [install github ssh keys](https://help.github.com/articles/generating-ssh-keys)
* [secure sudo](http://blog.rongarret.info/2015/08/psa-beware-of-sudo-on-os-x.html)
* don't forget to install Adobe things if necessary
* Dash license from 1Password
