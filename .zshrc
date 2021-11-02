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

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

export ANDROID_HOME=$HOME/Android
export ANDROID_SDK_ROOT=$ANDROID_HOME
export PATH=$ANDROID_SDK_ROOT/tools/bin:$PATH
export PATH=$ANDROID_SDK_ROOT/platform-tools:$PATH
export PATH=$ANDROID_SDK_ROOT/emulator:$PATH

export PATH="/home/mabub03/flutter/bin:$PATH"
export PATH=$VOLTA_HOME/bin:$PATH

#export PATH="$PATH:`pwd`/flutter/bin"
export PATH="$HOME/.cargo/bin:$PATH"
export CHROME_EXECUTABLE="/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe"
#export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"
#[ -f "/home/mabub03/.ghcup/env" ] && source "/home/mabub03/.ghcup/env" # ghcup-env

export EDITOR="nvim"
export VISUAL="nvim"

ZSH_THEME="cdimascio-lambda"
plugins=(git npm zsh-autosuggestions)
source $ZSH_CUSTOM/oh-my-zsh.sh

# alias to make update and upgrade one command
# alias update='sudo apt update && sudo apt upgrade'

alias luamake=/home/mabub03/dev/language_server/lua-language-server/3rd/luamake/luamake

