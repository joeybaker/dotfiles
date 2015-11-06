# dotfiles #

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
        # quote because syntax highlighting sucks
        installcommandlinetools="xcode-select --install"
        eval $installcommandlinetools

        brew install reattach-to-user-namespace brew-cask z the_silver_searcher ccat node tmux sshrc git zsh ack coreutils findutils bash shellcheck homebrew/dupes/grep httpie
        brew cask alfred link
        brew cask install google-chrome firefox iterm2 adium slate istat-menus airmail-beta spotify cloudup sublime-text-dev google-chrome-canary karabiner seil f-lux sidestep bartender onepassword alfred kitematic syncthing vlc atext --appdir=/Applications
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
    ```

* Install tmux plugin manager `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
    * start tmux with `tmux attach`
    * then: `<prefix> <ctrl-I>`
* `sudo sh ~/sh/osx.sh "my-computer-name"`
* install [nodejs](http://nodejs.org) & relevant global packages

    ```bash
    # no sudo for global installs!
    sudo chown -R $(whoami) ~/.npm; sudo chown -R $(whoami) /usr/local/lib/node_modules
    npm i -g nave grunt-cli bower supervisor nodemon npm-check-updates jscs jshint mocha ghwd ghcopy json trash-cli  irish-pub localhapi
    nave usemain stable
    npm config set init.author.name 'Joey Baker'
    npm config set init.author.email 'joey@byjoeybaker.com'
    npm config set init.author.site 'http://byjoeybaker.com'
    npm config set init.license Artistic-2.0
    npm config set init.version 0.0.0
    npm config set save-prefix "^"
    npm config set save true
    npm config set version true
    # authorize ghcopy, will prompt
    ghcopy-authorize
    ```

* [Karabiner](http://pqrs.org/macosx/karabiner/)
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
* [seil](http://pqrs.org/macosx/Karabiner/seil.html.en)
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
    * the hit list
        * enable sync from 1P
        * enable global shortcut
        * enable dock badge count
    * growl
        * enable on login
        * enable osx notifications
        * turn off menubar
        * turn off rollup
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

* [hosts file](http://someonewhocares.org/hosts/hosts)
    * `sudo rm /etc/hosts && cp ~/Sync/dotfiles/hosts /etc/hosts && sudo chmod 644 hosts`
* [sidestep](http://chetansurpur.com/projects/sidestep/)
    * [enable localhost](https://github.com/chetan51/sidestep/issues/32#issuecomment-16606585)
    * Network -> select device -> Advanced -> Proxies -> Bypass proxy settings: add "localhost"
* Chrome:
    * install 1Password extensions
    * ublock extension:
        * enable easy list
        * add: https://monzta.maltekraus.de/adblock_social.txt
* kill the dashboard
    * `defaults write com.apple.dashboard mcx-disabled -boolean true && killall Dock`
* setup time machine
* [install github ssh keys](https://help.github.com/articles/generating-ssh-keys)
* [secure sudo](http://blog.rongarret.info/2015/08/psa-beware-of-sudo-on-os-x.html)
* don't forget to install Adobe things if necessary
