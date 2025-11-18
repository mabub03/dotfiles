#!/bin/bash
sudo dnf in -y breeze-cursor-theme

sudo cp $HOME/dotfiles/cosmic_utilities/cosmic_cursor_setup/changed_files/environment /etc/
sudo cp $HOME/dotfiles/cosmic_utilities/cosmic_cursor_setup/changed_files/index.theme /usr/share/icons/

mkdir -p $HOME/.local/share/icons
sudo ln -s /usr/share/icons/default/ $HOME/.local/share/icons/default

gsettings set org.gnome.desktop.interface cursor-theme breeze_cursors

#cp $HOME/dotfiles/CosmicCursorSetup/ChangedFiles/settings.ini $HOME/.config/gtk-3.0/
#cp $HOME/dotfiles/CosmicCursorSetup/ChangedFiles/settings.ini $HOME/.config/gtk-4.0/
