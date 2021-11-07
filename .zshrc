zmodload zsh/zprof
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
export VOLTA_HOME=$HOME/.volta

export PATH=$VOLTA_HOME/bin:$PATH

export PATH="$PATH:`pwd`/flutter/bin"
export PATH="$HOME/.cargo/bin:$PATH"
export CHROME_EXECUTABLE="/usr/bin/microsoft-edge"

export EDITOR="nvim"
export VISUAL="nvim"

ZSH_THEME="cdimascio-lambda"
plugins=(git npm zsh-autosuggestions)
source $ZSH_CUSTOM/oh-my-zsh.sh

