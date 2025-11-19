#!/bin/bash
# setup repos
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf config-manager addrepo --from-repofile=https://openrazer.github.io/hardware:razer.repo
sudo dnf copr enable bieszczaders/kernel-cachyos-addons
sudo dnf config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo

# general packages
RPMPKGS=(
rustup
@virtualization
lz4
sudo-rs
yaru-icon-theme
fish
kernel-modules
just
curl
wget
btop
gnome-disk-utility
ananicy-cpp
cachyos-ananicy-rules
brave-browser
7zip
)

# fedora build essential equivalent
RPMPKGS+=(
make
gcc
gcc-c++
glibc-devel
#kernel-devel
#rpm-devel
)

# font packages
RPMPKGS+=(
google-tinos-fonts
google-cousine-fonts
google-arimo-fonts
google-crosextra-caladea-fonts
google-carlito-fonts
)

# obs packages
RPMPKGS+=(
  obs-studio
  v4l2loopback
)

# Apps I used to use as flatpaks and probably would again in an immutable system
RPMPKGS+=(
loupe
papers
foliate
celluloid
gnome-font-viewer
)

# remove this when cosmic screenshot organizer service isn't needed anymore
RPMPKGS+=(
inotify-tools
)

# probably should turn this into its own thing and dectect by chasis type 3 (desktop)
# if [[ $GAME_PROMPT == "y" || $GAME_PROMPT == "Y" ]]
# then
#   RPMPKGS+=(
#   mangohud
#   steam
#   )
# fi

# Install Nvidia Driver if nvidia is detected
if [ -d /sys/module/nvidia ]
then
  # Set up negativo17 repos for nvidia drivers
  sudo dnf config-manager addrepo --from-repofile=https://negativo17.org/repos/fedora-nvidia.repo
  sudo dnf config-manager setopt fedora-nvidia.repoid=90

	RPMPKGS+=(
	mangohud
	steam
	libva-nvidia-driver
	akmod-nvidia --disablerepo="rpmfusion-nonfree"
	)
fi

sudo dnf install -y "${RPMPKGS[@]}"
