# dotfiles

_This might be useful to turn this readme into a script: https://github.com/bkuhlmann/osx/blob/master/README.md_

- sys prefs
  - enable tap to click
  - enable triple hold to move <https://support.apple.com/en-us/HT204609>
  - enable four finger swipe down for expose
  - disable launch pad gesture
- turn on filevault
- app store for OS updates [restart]
- install [brew](http://brew.sh)

  - [some helpful tips](http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac) (incorporated below)

    ```sh
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    mkdir ~/.homebrew_temp/
    brew tap homebrew/cask-fonts

    # lua is for the neocomplete plugin vim plugin
    brew install reattach-to-user-namespace z ccat node tmux git zsh ack findutils bash shellcheck httpie jo mas autoenv coreutils cmake gpg rbenv yarn thefuck neovim python3 vale fd ripgrep fzf pgcli progress prettyping tldr bat hub gnu-sed grep pinentrya
    brew install --cask gitify google-chrome firefox iterm2 phoenix istat-menus cloudup karabiner-elements flux sidestep bartender 1password alfred syncthing atext dash SensibleSideButtons
    # fonts
    # [Source Code Pro](https://github.com/adobe/source-code-pro/downloads)
    # [patched fonts for terminal](https://github.com/Lokaltog/powerline-fonts)
    # [Inconsolata-g](http://leonardo-m.livejournal.com/77079.html)
    brew install --cask font-source-code-pro font-source-code-pro-for-powerline
    brew cleanup
    # viml linter
    pip3 install vim-vint --user
    # install for neovim
    # NOTE: installing RVM later might mean this will need to be re-installed
    sudo gem install neovim
    # install for deoplete in neovim
    pip3 install neovim
    # pip2 install neovim
    pip3 install diff-highlight
    pip3 install 'python-language-server[all]'
    ```

- install oceanic-next iTerm theme (the main theme is in the sync folder)

  ```sh
  git clone https://github.com/mhartington/oceanic-next-shell.git ~/.config/oceanic-next-shell
  ```

- follow install instructions for [zprezto](https://github.com/sorin-ionescu/prezto).

  ```bash
  # Clone the repository
  git clone --recursive https://github.com/joeybaker/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  # Create a new Zsh configuration by copying the Zsh configuration files provided
  setopt EXTENDED_GLOB
  for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  done
  ```

- setup 1password
- setup syncthing
- [install github ssh keys](https://help.github.com/articles/generating-ssh-keys)

  - Set a secure SSH key: https://blog.g3rt.nl/upgrade-your-ssh-keys.html
  - Set a gpg key for github: https://docs.gitlab.com/ee/user/project/repository/gpg_signed_commits/

          ```sh
          mkdir -p ~/.gnupg

          chown -R $(whoami) ~/.gnupg/
          echo "pinentry-program $(which pinentry)" > ~/.gnupg/gpg-agent.conf
          chmod 600 ~/.gnupg/\*
          chmod 700 ~/.gnupg
          gpgconf --kill gpg-agent
          gpg --full-gen-key
	  # Add gpg and ssh key to github
          ```

- dotfile link
          ```sh
	  cd ~ && git clone git@github.com:joeybaker/dotfiles.git && cd dotfiles`
          # NOTE: with symlinks and such, the zsh dotfiles might need to be moved to another location inside the `.zprezto` folder
          sh ~/dotfiles/link.sh "my-computer-name"`
  	  gpg --list-secret-keys --keyid-format LONG <<email>>
	  git config --file .gitconfig.local user.signingkey <<id>>
	  npm config set sign-git-tag true
	  ```
- Install vim plugins
  ```
  mkdir ~/.vim-tmp
  nvim +PlugInstall
  cd ~/.config/coc/extensions && yarn install --frozen-lockfile
  ```
- configure git: edit `~/dotfiles/gitconfig.local` with overrides. You can use `~/dotfiles/gitconfig` as a reference. You may want to change the email locally.
- Install tmux plugin manager `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
  - start tmux with `tmux`
  - then: `<prefix> <shift-I>`
- `sudo sh ~/sh/osx.sh "my-computer-name"`
- install [nodejs](http://nodejs.org) & relevant global packages

  ```bash
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
  # npm config set cache /Volumes/jbdb/npm
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
  mas install 1107421413 #1blocker
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
- cloudup: start and loginHHHHHHHLLLHHL
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
