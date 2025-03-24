#!/bin/bash
sudo dnf in -y breeze-cursor-theme

sudo cp $HOME/dotfiles/CosmicCursorSetup/ChangedFiles/environment /etc/
sudo cp $HOME/dotfiles/CosmicCursorSetup/ChangedFiles/index.theme /usr/share/icons/default/
ln -s /usr/share/icons/default/ /home/toasty/.local/share/icons/default

gsettings set org.gnome.desktop.interface cursor-theme breeze_cursors

cp $HOME/dotfiles/CosmicCursorSetup/ChangedFiles/settings.ini $HOME/.config/gtk-3.0/
cp $HOME/dotfiles/CosmicCursorSetup/ChangedFiles/settings.ini $HOME/.config/gtk-4.0/
