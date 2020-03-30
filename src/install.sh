#!/bin/bash

function action_echo() {
  tput setaf 4
  echo -n "$1 "
  for i in $(seq 1 3); do
    sleep 0.5
    echo -n "."
  done
  echo ""
  tput sgr0
}

########
# init #
########

# install xcode tools
action_echo "installing xcode tools"
xcode-select --install

# install brew and all needed packages
action_echo "installing brew and all needed packages"
if test ! $(which brew); then
  /bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi
brew update
brew tap homebrew/bundle
brew bundle

# use brew zsh version
if [ $(which zsh) != "$(brew --prefix)/bin/zsh" ]; then
  action_echo "use brew zsh version"
  sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh
fi

# apply mackup config
action_echo "applying mackup config"
ln -sf $(pwd)/config/.mackup.cfg ~/.mackup.cfg