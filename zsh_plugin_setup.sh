#!/bin/zsh
cp .zshrc $HOME
cd $HOME
source $HOME/.zshrc

git clone https://github.com/ohmyzsh/ohmyzsh.git $HOME/.oh-my-zsh
#sh - c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/cdimascio/lambda-zsh-theme.git
cd lambda-zsh-theme 
sudo cp cdimascio-lambda.zsh-theme $ZSH_CUSTOM/themes
cd $HOME

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# End Script by Sourcing Zsh
source $HOME/.zshrc
