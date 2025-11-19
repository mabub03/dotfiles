#!/bin/bash
sudo add-apt-repository ppa:openrazer/stable
sudo add-apt-repository ppa:polychromatic/stable

sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources https://brave-browser-apt-release.s3.brave.com/brave-browser.sources

sudo apt update

# essentials
APTPKGS+=(
  rustup
  fish
  eza
  curl
  wget
  btop
  build-essential
  ubuntu-restricted-extras
  yaru-theme-icon
  just
)

APTPKGS+=(
  fonts-croscore
  fonts-crosextra-caladea
  fonts-crosextra-carlito
)

# obs packages
APTPKGS+=(
  obs-studio
  v4l2loopback-source
  v4l2loopback-utils
  v4l2loopback-dkms
)

# general apps
APTPKGS+=(
  gnome-disk-utility
  brave-browser
  easyeffects
  virt-manager
  7zip
)

# stuff i would usually have as flatpak but wanna do native instead
APTPKGS+=(
  loupe
  foliate
  celluloid
  gnome-font-viewer
)

# remove this when cosmic screenshot organizer service isn't needed anymore
APTPKGS+=(
inotify-tools
)

if [ -d /sys/module/nvidia ]
then
  APTPKGS+=(
    mangohud
    steam
  )
fi

# openrazer and polychromatic
APTPKGS+=(
  polychromatic
  openrazer-meta
)

sudo apt install -y "${APTPKGS[@]}"
