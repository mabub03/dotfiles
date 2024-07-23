#!/bin/bash
mkdir -p $HOME/.local/share/sounds
cd $HOME/Downloads
git clone https://github.com/KDE/ocean-sound-theme.git
cp -r $HOME/Downloads/ocean-sound-theme/ocean $HOME/.local/share/sounds
gsettings set org.gnome.desktop.sound theme-name ocean
