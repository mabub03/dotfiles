#!/bin/zsh
cp $HOME/dotfiles/.zshrc $HOME
cd $HOME

#git clone https://github.com/ohmyzsh/ohmyzsh.git $HOME/.oh-my-zsh
#sh - c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#git clone https://github.com/cdimascio/lambda-zsh-theme.git
#cd lambda-zsh-theme 

#git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions

# exa install temporiarly put in here but should probably go in fedora script
# and wsl script when i feel like making wsl script
cargo install exa

sh -c "$(curl -fsSL https://starship.rs/install.sh)"
cp $HOME/dotfiles/.config/starship.toml $HOME/.config

# End Script by Sourcing Zsh
source $HOME/.zshrc
