#!/bin/bash
# disable fedora's background logo extension
gnome-extensions disable background-logo@fedorahosted.org

# enable ubuntu app indicator extension
gnome-extensions enable appindicatorsupport@rgcjonas.gmail.com

# gnome settings
gsettings set org.gnome.desktop.interface clock-format '24h'
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface color-scheme 'default'

gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'
gsettings set org.gnome.desktop.interface font-rgba-order 'rgb'
gsettings set org.gnome.desktop.interface font-hinting 'slight'
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'

#gsettings set org.gnome.desktop.interface monospace-font-name 'Geist Mono 11'
#gsettings set org.gnome.desktop.interface font-name 'Inter Variable 10.5'

# only use when on desktop maybe ask if wanna disable them
# disable sleep for when on AC power
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
# turn auto screen locking off
gsettings set org.gnome.desktop.screensaver lock-enabled false

gsettings set org.gnome.desktop.calendar show-weekdate true
