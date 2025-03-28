# use zprof to profile zsh
zmodload zsh/zprof
# load zsh's built in tetris
autoload -Uz tetriscurses
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

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
zstyle :compinstall filename '$HOME/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall
# ======================================================================
export LANG=en_US.UTF-8
#export VOLTA_HOME=$HOME/.volta

#export PATH=$VOLTA_HOME/bin:$PATH
#export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
#export PATH="/opt/apache-maven-3.9.8/apache-maven-3.9.8/bin:$PATH"

#export EDITOR="nvim"
#export VISUAL="nvim"

alias ls='eza --icons'
alias tetris='tetriscurses'

eval "$(starship init zsh)"

