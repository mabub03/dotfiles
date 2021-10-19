export ZSH_CUSTOM="/home/mabub03/.oh-my-zsh"

# ======================================================================
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch notify
unsetopt beep
# set vim mode
set -o vi
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/mabub03/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall
# ======================================================================
export LANG=en_US.UTF-8

export PATH="$PATH:`pwd`/flutter/bin"

#export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"
#[ -f "/home/mabub03/.ghcup/env" ] && source "/home/mabub03/.ghcup/env" # ghcup-env

export EDITOR="nvim"
export VISUAL="nvim"

ZSH_THEME="cdimascio-lambda"
plugins=(git npm zsh-autosuggestions)
source $ZSH_CUSTOM/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# alias to make update and upgrade one command
# alias update='sudo apt update && sudo apt upgrade'
