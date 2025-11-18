#!/bin/bash
#echo -n "Do you want to install Nvidia drivers? [y/N]"
#read NVIDIA_PROMPT

echo -n "Do you want to install Steam and other gaming utilities? [y/N]"
read GAME_PROMPT

#echo -n "Does your system have more than 16 GB of VRAM? [y/N]"
#read ZRAM_PROMPT

#echo -n "Is this a laptop? [y/N]"
#read LAPTOP_PROMPT

echo -n "What is your git email? "
read GIT_EMAIL

echo -n "What is your git username? "
read GIT_USERNAME

# rpm fusion free and non free
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
# add openrazer
sudo dnf config-manager addrepo --from-repofile=https://openrazer.github.io/hardware:razer.repo
sudo dnf copr enable bieszczaders/kernel-cachyos-addons
sudo dnf config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo

# remove the cosmic supplmentary apps group and fedora bookmarks package and then update to fetch mirrors and update the core
sudo dnf rm -y @cosmic-desktop-apps fedora-bookmarks
sudo dnf up -y
sudo dnf autoremove -y

# general packages
RPMPKGS=(
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
v4l2loopback
gnome-disk-utility
ananicy-cpp
cachyos-ananicy-rules
brave-browser
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

# Apps I used to use as flatpaks and probably would again in an immutable system
RPMPKGS+=(
loupe
papers
foliate
celluloid
obs-studio
g4music
pinta
)

# Install Nvidia Driver if nvidia is detected
if [ -d /sys/module/nvidia ]
then
  # Set up negativo17 repos for nvidia drivers
  sudo dnf config-manager addrepo --from-repofile=https://negativo17.org/repos/fedora-nvidia.repo
  sudo dnf config-manager setopt fedora-nvidia.repoid=90

	RPMPKGS+=(
	libva-nvidia-driver
	akmod-nvidia --disablerepo="rpmfusion-nonfree"
	)
fi

# delete fedora default flatpak repo and add flathub and cosmic repos
# also technically correct to user --user flathub for all apps possible though flathub system has benefits like gpu screen recorder's new ui only works with flathub system not flathub user
sudo flatpak remote-delete fedora
#sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists --user cosmic https://apt.pop-os.org/cosmic/cosmic.flatpakrepo

#SYSTEMFLATPAKS=(
#com.dec05eba.gpu_screen_recorder
#)

FLATPAKS=(
com.dec05eba.gpu_screen_recorder
org.gtk.Gtk3theme.adw-gtk3
org.gtk.Gtk3theme.adw-gtk3-dark
#com.obsproject.Studio
#com.obsproject.Studio.Plugin.Gstreamer
com.spotify.Client
com.discordapp.Discord
org.freedesktop.Platform
md.obsidian.Obsidian
com.github.tchx84.Flatseal
io.missioncenter.MissionCenter
org.freedesktop.Platform.ffmpeg-full
io.github.nozwock.Packet
io.gitlab.theevilskeleton.Upscaler
dev.edfloreshz.CosmicTweaks
page.codeberg.libre_menu_editor.LibreMenuEditor
)

# clipboard manager via flatpak doesn't work due to a change in the protocol not supporting flatpaks
#COSMICFLATPAKS=(
#io.github.cosmic_utils.cosmic-ext-applet-clipboard-manager
#)

if [[ $GAME_PROMPT == "y" || $GAME_PROMPT == "Y" ]]
then
  RPMPKGS+=(
  mangohud
  steam
  )
  
  FLATPAKS+=(
   com.vysp3r.ProtonPlus
  )

  # setup controller udev rules
  cd $HOME && git clone https://codeberg.org/fabiscafe/game-devices-udev.git
  sudo cp game-devices-udev/*.rules /etc/udev/rules.d/
  echo uinput | sudo tee /etc/modules-load.d/uinput.conf
  rm -rf $HOME/game-devices-udev

  cp -r $HOME/dotfiles/files/home/.config/MangoHud $HOME/.config/
fi

# install all the rpm pkgs, flatpaks, and extras
sudo dnf install -y "${RPMPKGS[@]}"
# razer associated packages had to include them seperatly because kernel headers are required and part of the previous transaction so not fully installed for openrazer until the previous transaction is finished
# remove whenever i stop getting razer mice
sudo dnf in openrazer-meta polychromatic
flatpak install --user flathub "${FLATPAKS[@]}"
#flatpak install flathub "${SYSTEMFLATPAKS[@]}"
#flatpak install cosmic "${COSMICFLATPAKS[@]}"

curl -f https://zed.dev/install.sh | sh
#curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh && source .bashrc
sudo dnf install rustup && rustup-init && source .bashrc
cargo install eza

# setup virtualization
sudo gpasswd -a $(whoami) libvirt
sudo systemctl enable --now libvirtd
sudo virsh net-autostart default

# flatpak app broken so gotta build the clipboard manager and hope things work
sudo dnf install -y libxkbcommon-devel
cd $HOME && git clone https://github.com/cosmic-utils/clipboard-manager.git
cd clipboard-manager && just build-release && sudo just install && cd $HOME

# flatpak overrides
flatpak override --user --socket=wayland
#sudo flatpak override io.github.celluloid_player.Celluloid --filesystem=xdg-config/mpv

# setup full codecs
# for amd systems using mesa
# sudo dnf swap -y mesa-va-drivers mesa-va-drivers-freeworld
# sudo dnf swap -y mesa-vdpau-drivers mesa-vdpau-drivers-freeworld
# sudo dnf swap -y mesa-va-drivers.i686 mesa-va-drivers-freeworld.i686 # for steam and maybe obs
# sudo dnf swap -y mesa-vdpau-drivers.i686 mesa-vdpau-drivers-freeworld.i686 # for steam and maybe obs
# for intel
# sudo dnf install -y intel-media-driver
sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
sudo dnf update -y @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin

# TODO:setup zram (still haven't decided if i wanna keep this config so it is commented out for now)
#sudo cp $HOME/dotfiles/files/etc/systemd/zram-generator.conf /etc/systemd/
#systemctl restart systemd-zram-setup@zram0.service

# setup sysctl optimizations (pop os zram /proc/sys/vm settings and steam deck & pop os /proc/sys/vm/max-map-count value)
sudo cp $HOME/dotfiles/etc/sysctl.d/99-vm-zram-params.conf /etc/sysctl.d/
sudo cp $HOME/dotfiles/etc/sysctl.d/99-vm-max-map-count.conf /etc/sysctl.d/
sudo sysctl -p /etc/sysctl.d/99-vm-zram-params.conf
sudo sysctl -p /etc/sysctl.d/99-vm-max-map-count.conf

# setup firefox and brave
sudo cp -r $HOME/dotfiles/etc/brave /etc/
#cp -r $HOME/dotfiles/files/home/.config/BraveSoftware /$HOME/.config/
sudo cp -r $HOME/dotfiles/etc/firefox /etc/
cp $HOME/dotfiles/home/.mozilla/firefox/default-release/user.js $HOME/.mozilla/firefox/*.default-release

# setup git with credentials entered above
git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_USERNAME"

# install and set up ibm plex sans and mono fonts as default
source $HOME/dotfiles/scripts/setup_ibm_plex_fonts.sh
source $HOME/dotfiles/cosmic_utilities/cosmic_cursor_setup/setup_cosmic_cursor.sh
# copy things from dotfiles .config to $HOME/.config
# cp $HOME/dotfiles/BackedUpFiles/.config/starship.toml $HOME/.config/
cp -r $HOME/dotfiles/home/.config/fontconfig $HOME/.config/
cp -r $HOME/dotfiles/home/.config/fish $HOME/.config/
cp -r $HOME/dotfiles/home/.config/cosmic $HOME/.config/

echo 'export COSMIC_DATA_CONTROL_ENABLED=1' | sudo tee /etc/profile.d/data_control_cosmic.sh > /dev/null

# add user to required groups
# remove whenever i stop getting razer mice
sudo gpasswd -a $USER plugdev

# set up services
sudo systemctl enable --now ananicy-cpp

# hopefully just a temp service so bundling in the cp command also for easier removal later
mkdir $HOME/Pictures/Screenshots
cp -r $HOME/dotfiles/cosmic_utilities/screenshot_organizer/config/systemd $HOME/.config/
cp -r $HOME/dotfiles/cosmic_utilities/screenshot_organizer/local/bin $HOME/.local/
systemctl --user daemon-reload
systemctl --user enable --now cosmic_screenshot_organizer.service

# add wifi powersave file to deactivate wifi powersave
sudo bash -c 'cat > /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf' <<-'EOF'
[connection]
wifi.powersave=2
EOF

sudo systemctl restart NetworkManager

# TODO after a install and run of this script make sure these universal variables got applied
fish -c "set -U ELECTRON_OZONE_PLATFORM_HINT auto"
if [ -d /sys/module/nvidia ]
then
  fish -c "set -U __GL_SHADER_DISK_CACHE_SIZE 12884901888"
fi

# change default shell to fish
while true; do
  sudo chsh -s $(which fish) $(whoami)
  if [ $? -eq 0 ]; then
    echo "Default shell changed to fish"
    break
  else
    echo "Failed to change default shell. Please try again."
  fi
done

echo "Setup script has finished running"
echo "Restart your computer now for changes to take effect"
