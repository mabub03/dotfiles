#!/bin/bash
echo -n "What is your git email? "
read GIT_EMAIL

echo -n "What is your git username? "
read GIT_USERNAME

# update pop os
sudo apt update && sudo apt upgrade -y
# remove certain things that i don't want or wouldn't work well via package manager compared to flatpak (like gnome-boxes)
sudo apt remove eog \
  totem \
  libtotem-plparser18 \
  libtotem0

source $HOME/dotfiles/scripts/popos/packages.sh

# install rust
rustup default stable && source $HOME/.bashrc

# flatpak app broken so gotta build the clipboard manager and hope things work
cd $HOME && git clone https://github.com/cosmic-utils/clipboard-manager.git
cd clipboard-manager && just build-release && sudo just install && cd $HOME

# setup virtualization
sudo gpasswd -a $(whoami) libvirt
sudo systemctl enable --now libvirtd
sudo virsh net-autostart default

# cachy os changes kptr_restrict to 2 for more security while ubuntu and pop sets to 1 so just move that one sysctl file for pop installs
sudo cp $HOME/dotfiles/etc/sysctl.d/99-kernel-hardening.conf /etc/sysctl.d
sudo sysctl --system

# TODO: remove this when 26.04 comes out and use native papers app
flatpak install flathub org.gnome.Papers

source $HOME/dotfiles/scripts/flatpak
source $HOME/dotfiles/scripts/common.sh
