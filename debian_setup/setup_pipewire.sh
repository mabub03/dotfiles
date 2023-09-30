#!/bin/bash
GREEN="\e[32m"

# setup pipewire (sadly kde version in debian 12 still uses pulse)
# for some reason jack not included in pipewire-audio hence why it is here
sudo apt install -y pipewire-audio pipewire-jack

# wiki said to do this but no file in /usr/share/doc/pipewire/examples/alsa.conf.d/99-pipewire-default,
# but after checking /etc/alsa/conf.d after a restart the files were there
# sudo cp /usr/share/doc/pipewire/examples/alsa.conf.d/99-pipewire-default.conf /etc/alsa/conf.d/

sudo cp /usr/share/doc/pipewire/examples/ld.so.conf.d/pipewire-jack-*.conf /etc/ld.so.conf.d/
sudo ldconfig

systemctl --user --now enable wireplumber.service

# wiki says to reboot after enabling wireplumber service to get pipewire-pulse all ready and working properly
# after reboot can check to see if using pipewire if it says, Server Name: PulseAudio (on PipeWire)
# with the command: LANG=C pactl info | grep '^Server Name'
printf "${GREEN}"
cat <<EOL
================================================================================
Congratulations, pipewire & wireplumber is installed and setup please reboot!
================================================================================
EOL
