#!/bin/bash
#install yay
sudo pacman -S git
cd /opt
sudo git clone https://aur.archlinux.org/yay-git.git
sudo chown -R tecmint:tecmint ./yay-git
cd yay-git
makepkg -si

# install the rest of the prerequisites 
sudo pacman -S i3 i3status i3lock dmenu xorg-xset xorg-xrandr pasystray xclip avahi firefox-developer-edition
yay -S polybar
yay -S autotiling
yay -S i3-gaps-rounded-git
yay -S brave

# enable to auto start certain prerequisites
sudo systemctl enable avahi-daemon

cp .xinitrc $HOME
cp .Xresources $HOME
cp .xprofile $HOME
cp -r .config/nvim $HOME/.config
cp -r .config/fontconfig $HOME/.config
cp -r .config/i3 $HOME/.config
cp -r .config/polybar $HOME/.config
cp -r .config/kitty $HOME/.config
