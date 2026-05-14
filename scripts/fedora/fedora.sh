#!/bin/bash
echo -n "What is your git email? "
read GIT_EMAIL

echo -n "What is your git username? "
read GIT_USERNAME

# this will disable the ibus notification that shows up at startup for fedora cosmic spin
#sudo sed -i 's/KDE-wayland/COSMIC-wayland/g' /etc/X11/xinit/xinput.d/ibus.conf

# remove the cosmic supplmentary apps group and fedora bookmarks package and then update to fetch mirrors and update the core
sudo dnf rm -y @cosmic-desktop-apps fedora-bookmarks abrt
sudo dnf up -y
sudo dnf autoremove -y

# set up repos and add packages to an array and then install them
source $HOME/dotfiles/scripts/fedora/packages.sh

# setup full codecs
sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
sudo dnf update -y @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin

# setup codecs for amd if on a device with a amd gpu or apu or setup codecs for intel if on a system with a intel gpu
if [ -d /sys/module/amdgpu ]
then
  sudo dnf swap -y mesa-va-drivers mesa-va-drivers-freeworld
  sudo dnf swap -y mesa-vdpau-drivers mesa-vdpau-drivers-freeworld
  sudo dnf swap -y mesa-va-drivers.i686 mesa-va-drivers-freeworld.i686 # for steam and maybe obs
  sudo dnf swap -y mesa-vdpau-drivers.i686 mesa-vdpau-drivers-freeworld.i686 # for steam and maybe obs
elif [[ -d /sys/module/i915 || -d /sys/module/xe ]]
then
  sudo dnf install -y intel-media-driver
fi

# delete fedora default flatpak repo and add flathub and cosmic repos
# also technically correct to user --user flathub for all apps possible though flathub system has benefits like gpu screen recorder's new ui only works with flathub system not flathub user
sudo flatpak remote-delete fedora
#sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# razer associated packages had to include them seperatly because kernel headers are required and part of the previous transaction so not fully installed for openrazer until the previous transaction is finished
# remove whenever i stop getting razer mice
sudo dnf in -y kernel-devel-$(uname -r)
sudo dnf in -y openrazer-meta polychromatic

# setup virtualization
#sudo gpasswd -a $(whoami) libvirt
#sudo systemctl enable --now libvirtd
#sudo virsh net-autostart default

# setup services
#sudo systemctl enable --now ananicy-cpp
sudo systemctl enable --now com.system76.Scheduler.service

#curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh && source .bashrc
# setup rust and install eza since somehow that still isn't in fedora repos
rustup-init && source $HOME/.bashrc
cargo install eza

source $HOME/dotfiles/scripts/flatpaks.sh
source $HOME/dotfiles/scripts/common.sh
