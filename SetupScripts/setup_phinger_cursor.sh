#!/bin/bash
# setup phinger
mkdir -p ~/.local/share/icons
wget -cO- https://github.com/phisch/phinger-cursors/releases/latest/download/phinger-cursors-variants.tar.bz2 | tar xfj - -C ~/.local/share/icons

# set gnome cursor theme to phinger
gsettings set org.gnome.desktop.interface cursor-theme 'phinger-cursors-dark'
