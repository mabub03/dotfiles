#!/bin/bash
echo -n "Do you need to create your own secure boot key for nvidia or a different package? [y/N]"
read MOKUTIL_PROMPT

sudo dnf in -y @admin-tools \
  @anaconda-tools \
  @base-graphical \
  @core \
  @desktop-accessibility \
  @firefox \
  @fonts \
  @guest-desktop-agents \
  @hardware-support \
  @libreoffice \
  @multimedia \
  @networkmanager-submodules \
  @printing \
  @virtualization \
  @standard

systemctl set-default graphical.target

sudo dnf copr enable -y ryanabx/cosmic-epoch
sudo dnf install -y cosmic-desktop

if [[ $MOKUTIL_PROMPT == "y" || $MOKUTIL_PROMPT == "Y" ]]
then
  sudo dnf install kmodtool akmods mokutil openssl
  sudo kmodgenca -a
  sudo mokutil --import /etc/pki/akmods/certs/public_key.der
fi