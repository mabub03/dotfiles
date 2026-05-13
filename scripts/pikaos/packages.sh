#!/bin/bash
curl -fsSL 'https://debian.polychromatic.app/key.asc' | sudo gpg --dearmour -o /usr/share/keyrings/polychromatic.gpg

source /etc/os-release
echo "deb [signed-by=/usr/share/keyrings/polychromatic.gpg] https://debian.polychromatic.app $VERSION_CODENAME main" | sudo tee /etc/apt/sources.list.d/polychromatic.list

pikman update

# ======= REMOVE =======
# can't remove xterm because steam depends on it, and will just install a 32 bit version instead
REMOVE=(
lutris
heroic-games-launcher
synaptic
chromium
pavucontrol
gnome-calendar
gnome-contacts
simple-scan
gnome-firmware
gnome-system-monitor
baobab
gnome-calculator
gnome-clocks
gnome-weather
)

# pika-codecs-meta gets removed also though the codecs will stay
REMOVE+=(
vlc
)

# removes pika-welcome
REMOVE+=(
webapp-manager
)

# password and keys app
REMOVE+=(
seahorse
)

# emoji app
REMOVE+=(
gnome-characters
)

# character-map app that comes with pop os but is retired by gnome
REMOVE+=(
gucharmap
)

# i usually use this but if there is a cosmic image app that is good maybe use that
#REMOVE+=(
#loupe
#)

# ======= INSTALL =======
# General Apps
INSTALL=(
easyeffects
7zip
foliate
spotify-client
discord
gnome-boxes
)

# Gaming Apps
INSTALL+=(
pika-gameutils-meta
)

# Essentials
INSTALL+=(
rustup
fish
eza
btop
build-essential
just
)

# OpenRazer
INSTALL+=(
polychromatic
openrazer-meta
)

# OBS
#INSTALL+=(
#obs-studio
#v4l2loopback-source
#v4l2loopback-utils
#v4l2loopback-dkms
#)

# Printer
#INSTALL+=(
#cups
#cups-filters
#cups-pk-helper
#printer-driver-all
#system-config-printer
#)

# Fonts
INSTALL+=(
fonts-croscore
fonts-crosextra-caladea
fonts-crosextra-carlito
)

pikman install "${INSTALL[@]}" -y
pikman remove "${REMOVE[@]}" -y
pikman autoremove

mkdir -p $HOME/.config/autostart/
cp /etc/xdg/autostart/nm-applet.desktop $HOME/.config/autostart/
sed -i '/NotShowIn=/s/$/COSMIC;/' $HOME/.config/autostart/