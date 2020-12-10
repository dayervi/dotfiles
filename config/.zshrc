#######
# zsh #
#######

export ZSH=~/.oh-my-zsh

ZSH_THEME="common"
ZSH_DISABLE_COMPFIX=true

plugins=(
  extract
  forklift
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# prevent % char on starting prompt
unsetopt PROMPT_SP

source $ZSH/oh-my-zsh.sh


########
# VARS #
########

#bat cli theme
export BAT_THEME="base16"


########
# PATH #
########

# homebrew priority
PATH=/usr/local/bin:$PATH


##############
# COMPLETION #
##############
