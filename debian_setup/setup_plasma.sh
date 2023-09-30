#!/bin/bash
# if ever need a share desktop through local network with another user app install krfb
sudo apt install -y \
  plasma-desktop \
  plasma-nm \
  konsole \
  kate \
  kdialog \
  dolphin \
  dolphin-plugins \
  kfind \
  ark \
  kcharselect \
  kde-spectacle \
  kcolorchooser \
  kde-config-flatpak \
  print-manager \
  kaccounts-integration \
  kaccounts-providers \
  colord-kde \
  plasma-widgets-addons \
  kwin-addons \
  ksystemlog \
  vulkan-tools \
  sddm

# install kde widgets
mkdir $HOME/widgets-source
cd $HOME/widgets-source
git clone https://github.com/psifidotos/applet-window-title.git
cd applet-window-title
kpackagetool5 -i .

cd $HOME/widgets-source
git clone https://github.com/Zren/plasma-applet-eventcalendar.git eventcalendar
cd eventcalendar
sh ./install

sudo systemctl enable sddm
