#!/bin/bash
git clone https://github.com/cdimascio/lambda-zsh-theme.git
cd lambda-zsh-theme 
cp cdimascio-lambda.zsh-theme $ZSH_CUSTOM/themes
cd

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# End Script by Sourcing Zsh
source ~/.zshrc
