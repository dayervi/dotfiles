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

function color_echo() {
  tput setaf $2
  echo "$1"
  tput sgr
}

function ask_permission() {
  tput setaf 3
  read -n 1 -p "warning: $1, continue (y/n)? " answer
  echo ""
  tput sgr0
  
  case ${answer} in
    y|Y ) return 1 ;;
    * ) return 0 ;;
  esac
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

# apply proper zsh configuration file on home
[ -e ~/.zshrc ] && ask_permission "overriding .zshrc file on your home"
if [ $? -eq 1 ]; then
  action_echo "configuring zsh"
  ln -sf $(pwd)/config/.zshrc ~/.zshrc
else
  color_echo "zsh configuration has not been applied" 5
fi

# apply gitconfig
[ -e ~/.gitconfig ] && ask_permission "overriding .gitconfig file on your home"
if [ $? -eq 1 ]; then
  action_echo "configuring git"
  ln -sf $(pwd)/config/.gitconfig ~/.gitconfig
  ln -sf $(pwd)/config/.gitignore_global ~/.gitignore_global
else
  color_echo "git configuration has not been applied" 5
fi

# apply mackup config
action_echo "applying mackup config"
ln -sf $(pwd)/config/.mackup.cfg ~/.mackup.cfg
