#!/bin/bash

source $(dirname $0)/_common.sh


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


#################
# common config #
#################

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
  ln -sf $(pwd)/config/.gitconfig-ct ~/.gitconfig-ct
  ln -sf $(pwd)/config/.gitignore_global ~/.gitignore_global
  if [ -z $(git config --global user.email) ]; then
    email=$(ask "set global git config user.email:")
    if [[ $email =~ .+@.+\..+ ]]; then
      git config --global user.email "$email"
    else
      color_echo "git user email configuration has not been applied [error: unvalid email]" 5
    fi
  fi
else
  color_echo "git configuration has not been applied" 5
fi

# apply mackup config
# action_echo "applying mackup config"
# ln -sf $(pwd)/config/.mackup.cfg ~/.mackup.cfg


####################
# specific configs #
####################

# proper java config
# action_echo "configuring java"
# jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-14.jdk/Contents/Home/
# jenv global openjdk64-14
# ln -sf $(pwd)/config/.mavenrc ~/.mavenrc

# install atom packages
action_echo "install atom packages"
apm install --package-file $(pwd)/data/atom-needed-packages.txt

action_echo "applying some macosx config"
source $(pwd)/config/.macosx

color_echo "setting done 👌" 2
