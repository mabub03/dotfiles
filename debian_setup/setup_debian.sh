#!/bin/bash

# Add needed packages
# NOTICE: use for minimal install script
# TODO: just run debian and see if you need to add more to this
sudo apt install -y \
  build-essential \
  git \
  zsh \
  btop \
  neovim \
  wget \
  apt-transport-https \
  gpg \
  curl

# remove whatever isn't needed from the system (have after all the installing of packages)
sudo apt update && sudo apt upgrade -y
sudo apt autoremove

#NOTE: maybe add this somewhere else but will need rust for sys76-scheduler and zsh setup, so fine here for now
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Add fonts
mkdir $HOME/.local/share/fonts
cd $HOME/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
unzip JetBrainsMono.zip
rm -rf JetBrainsMono.zip

# setup font rendering (maybe even install ubuntu vm and see what is in /etc/fonts/conf.d compared to fedora setup)
sudo ln -fs /usr/share/fontconfig/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d/
cp $HOME/dotfiles/.config/fontconfig/fonts.conf $HOME/.config/fontconfig/fonts.conf
fc-cache -fv

# move .config items
cp -r $HOME/dotfiles/.config/btop $HOME/.config/btop
cp -r $HOME/dotfiles/.config/gtk-3.0 $HOME/.config/gtk-3.0
cp -r $HOME/dotfiles/.config/gtk-4.0 $HOME/.config/gtk-4.0

# disabe wifi powersave
sudo bash -c 'cat > /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf' <<-'EOF'
[connection]
wifi.powersave=2
EOF

sudo systemctl restart NetworkManager

echo "Setup script has finished running"

