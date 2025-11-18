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
  kernel-modules-extra \
  @standard

# setup the virtualization services and set current user in the libvirt group
sudo systemctl start libvirtd
sudo systemctl enable libvirtd
sudo usermod -a -G libvirt $(whoami)

# set some selinux booleans that the workstation version has
sudo setsebool -P selinuxuser_execmod 1
sudo setsebool -P virt_sandbox_use_all_caps 1
sudo setsebool -P virt_sandbox_use_nfs 1

# set fedora to load into graphics mode
systemctl set-default graphical.target

sudo dnf copr enable -y ryanabx/cosmic-epoch
sudo dnf in -y cosmic-desktop

sudo dnf rm abrt

if [[ $MOKUTIL_PROMPT == "y" || $MOKUTIL_PROMPT == "Y" ]]
then
  sudo dnf in -y kmodtool akmods mokutil openssl
  sudo kmodgenca -a
  sudo mokutil --import /etc/pki/akmods/certs/public_key.der
fi