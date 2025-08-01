#!/bin/bash
echo -n "What is your git email? "
read GIT_EMAIL

echo -n "What is your git username? "
read GIT_USERNAME

echo -n "Do you want to install Steam and other gaming utilities? [y/N]"
read GAME_PROMPT

sudo pacman -Syu

if [[ $GAME_PROMPT == "y" || $GAME_PROMPT == "Y" ]]
then

# install all gaming related packages
sudo pacman -S gamescope \
  goverlay \
  heroic-games-launcher \
  lib32-mangohud mangohud \
  steam \
  steam-native-runtime \
  wqy-zenhei \
  alsa-plugins \
  giflib glfw \
  gst-plugins-base-libs \
  lib32-alsa-plugins \
  lib32-giflib \
  lib32-gst-plugins-base-libs \
  lib32-gtk3 \
  lib32-libjpeg-turbo \
  lib32-libva \
  lib32-mpg123 \
  lib32-ocl-icd \
  lib32-opencl-icd-loader \
  lib32-openal \
  libjpeg-turbo \
  libva libxslt \
  mpg123 \
  opencl-icd-loader \
  openal proton-cachyos \
  ttf-liberation \
  vulkan-tools \
  proton-ge-custom-bin \
  umu-launcher

  cp -r $HOME/dotfiles/BackedUpFiles/.config/MangoHud $HOME/.config/
fi

# install general packages
sudo pacman -S brave-bin \
  7zip \
  base-devel \
  virt-manager \
  rust \
  rust-analyzer \
  just \
  gnome-disk-utility \
  ttf-croscore \
  ttf-caladea \
  ttf-carlito \
  v4l2loopback-dkms \
  v4l2loopback-utils \
  obs-studio \
  obsidian \
  zed

# install all video, audio, and image codecs
sudo pacman -S ffmpeg \
  gst-plugins-good \
  gst-plugins-bad \
  gst-plugins-ugly \
  gst-plugins-base \
  gst-libav \
  gstreamer \
  celt \
  libmad \
  jasper \
  libavif \
  libheif \
  schroedinger

# install apps that i would usually have as flatpaks on other distros
# might move them back to flatpak slowly idk will see how it goes
# see if these are needed for easyeffects because it adds in an app i don't want called ardour
# lsp-plugins-lv2 zam-plugins-lv2 mda.lv2 calf
sudo pacman -S loupe \
  celluloid \
  easyeffects \
  gpu-screen-recorder-ui \
  foliate \
  discord \
  spotify-launcher \
  papers \
  gimp \
  gnome-font-viewer \
  mission-center

# setup flathub and install flatpak apps
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists --user cosmic https://apt.pop-os.org/cosmic/cosmic.flatpakrepo

flatpak install -y flathub org.gtk.Gtk3theme.adw-gtk3 \
  org.gtk.Gtk3theme.adw-gtk3-dark \
  com.github.tchx84.Flatseal \
  com.github.neithern.g4music \
  io.github.nozwock.Packet \
  com.github.PintaProject.Pinta \
  org.freedesktop.Platform/x86_64/24.08 \
  io.gitlab.theevilskeleton.Upscaler

# install cosmic applets with flatpak
#flatpak install cosmic co.uk.cappsy.CosmicAppletLogoMenu

# flatpak overrides
sudo flatpak override --socket=wayland

# i use my own fish config so yeet the cachy one
rm -rf $HOME/.config/fish/*
sudo pacman -Rn cachyos-fish-config

# setup git with credentials entered above
git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_USERNAME"

# install and set up ibm plex sans and mono fonts as default
source $HOME/dotfiles/SetupScripts/setup_ibm_plex_fonts.sh

# copy things from dotfiles .config to $HOME/.config
# cp $HOME/dotfiles/BackedUpFiles/.config/starship.toml $HOME/.config/
cp -r $HOME/dotfiles/BackedUpFiles/.config/fontconfig $HOME/.config/
cp -r $HOME/dotfiles/BackedUpFiles/.config/fish $HOME/.config/
cp -r $HOME/dotfiles/BackedUpFiles/.config/zed $HOME/.config/
cp -r $HOME/dotfiles/BackedUpFiles/.config/cosmic $HOME/.config/

# cosmic util setup - screenshot organizer and fix nvidia vram wayland issues for cosmic
cp -r $HOME/dotfiles/BackedUpFiles/CosmicUtils/ScreenshotOrganizer/config/systemd $HOME/.config/
mkdir mkdir -p $HOME/.local/bin && cp -r $HOME/dotfiles/BackedUpFiles/CosmicUtils/ScreenshotOrganizer/local/bin/cosmic_screenshot_organizer.sh $HOME/.local/bin/
source $HOME/dotfiles/BackedUpFiles/CosmicUtils/nvidia-vram-wayland-fix.sh
systemctl --user daemon-reload
systemctl --user enable --now cosmic_screenshot_organizer.service

# setup firefox and brave
sudo cp -r $HOME/dotfiles/BackedUpFiles/etc/brave /etc/
cp -r $HOME/dotfiles/BackedUpFiles/.config/BraveSoftware /$HOME/.config/
sudo cp -r $HOME/dotfiles/BackedUpFiles/etc/firefox /etc/
cp $HOME/dotfiles/BackedUpFiles/firefox/default-release/user.js $HOME/.mozilla/firefox/*.default-release

# replace all the adwaita fonts with ibm plex for gnome apps to use ibm plex and also make sure gnome apps use rgb (don't know if needed to do all this but it doesn't hurt)
gsettings set org.gnome.desktop.interface font-name 'IBM Plex Sans 10'
gsettings set org.gnome.desktop.interface monospace-font-name 'IBM Plex Mono 10'
gsettings set org.gnome.desktop.interface document-font-name 'IBM Plex Sans 10'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'IBM Plex Sans Bold 10'
gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'
gsettings set org.gnome.desktop.interface font-rgba-order 'rgb'
gsettings set org.gnome.desktop.interface font-hinting 'slight'

# setup cosmic cursor
# TODO: Reverse this and delete this when it becomes a real cosmic setting
paru -S xcursor-breeze

sudo cp $HOME/dotfiles/CosmicCursorSetup/ChangedFiles/ArchConfig/environment /etc/environment
sudo cp $HOME/dotfiles/CosmicCursorSetup/ChangedFiles/ArchConfig/index.theme /usr/share/icons/default/index.theme

mkdir -p $HOME/.local/share/icons
sudo ln -s /usr/share/icons/default/ /home/toasty/.local/share/icons/default

gsettings set org.gnome.desktop.interface cursor-theme Breeze

# add wifi powersave file to deactivate wifi powersave
sudo bash -c 'cat > /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf' <<-'EOF'
[connection]
wifi.powersave=2
EOF

sudo systemctl restart NetworkManager

echo "Setup script has finished running"
echo "Restart your computer now for changes to take effect"
