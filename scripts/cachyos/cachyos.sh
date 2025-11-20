#!/bin/bash
echo -n "What is your git email? "
read GIT_EMAIL

echo -n "What is your git username? "
read GIT_USERNAME

sudo pacman -Rns pavucontrol meld alacritty --noconfirm
sudo pacman -Syu --noconfirm

# essentials
PKGS=(
  rustup
  btop
  yaru-icon-theme
  just
  sudo-rs
)

# fonts
PKGS+=(
  ttf-croscore
  ttf-caladea
  ttf-carlito
)

# install all video, audio, and image codecs
PKGS+=(
  ffmpeg
  gst-plugins-good
  gst-plugins-bad
  gst-plugins-ugly
  gst-plugins-base
  gst-libav
  gstreamer
  celt
  libmad
  jasper
  libavif
  libheif
  schroedinger
)

# general apps
PKGS+=(
  gnome-disk-utility
  brave-bin
  easyeffects
  virt-manager
  7zip
)

# obs packages
PKGS+=(
  obs-studio
  v4l2loopback-utils
  v4l2loopback-dkms
)
# install apps that i would usually have as flatpaks on other distros
# might move them back to flatpak slowly idk will see how it goes
PKGS+=(
  loupe
  celluloid
  foliate
  papers
  gnome-font-viewer
)

# remove this when cosmic screenshot organizer service isn't needed anymore
PKGS+=(
inotify-tools
)

if [ -d /sys/module/nvidia ]
then
  # install all gaming related packages (just took the gaming meta package and removed the stuff i don't use)
  PKGS+=(
    goverlay
    heroic-games-launcher
    lib32-mangohud
    mangohud
    steam
    steam-native-runtime
    wqy-zenhei
    alsa-plugins
    giflib glfw
    gst-plugins-base-libs
    lib32-alsa-plugins
    lib32-giflib
    lib32-gst-plugins-base-libs
    lib32-gtk3
    lib32-libjpeg-turbo
    lib32-libva
    lib32-mpg123
    lib32-ocl-icd
    lib32-opencl-icd-loader
    lib32-openal
    libjpeg-turbo
    libva
    libxslt
    mpg123
    opencl-icd-loader
    openal proton-cachyos
    ttf-liberation
    vulkan-tools
    proton-ge-custom-bin
  )
fi

# openrazer and polychromatic
PKGS+=(
  linux-headers
  polychromatic
  openrazer-daemon
)

sudo pacman -S --noconfirm "${APTPKGS[@]}"

# setup vms
sudo gpasswd -a $(whoami) libvirt
sudo systemctl enable --now libvirtd
sudo virsh net-autostart default

source $HOME/dotfiles/scripts/flatpak
source $HOME/dotfiles/scripts/common.sh
