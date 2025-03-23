#!/bin/bash
echo -n "Do you want to install Nvidia drivers? [y/N]"
read NVIDIA_PROMPT

echo -n "Do you want to install Steam and other gaming utilities? [y/N]"
read GAME_PROMPT

#echo -n "Is this a laptop? [y/N]"
#read LAPTOP_PROMPT

echo -n "What is your git email? "
read GIT_EMAIL

echo -n "What is your git username? "
read GIT_USERNAME

# rpm fusion free and non free (sadly still need since fedora 35+ doesn't include the full rpm fusion repos just a couple packages from it)
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf rm -y @cosmic-desktop-apps

sudo dnf up -y

sudo dnf in -y git \
  fish \
  make \
  gcc \
  eza \
  curl \
  wget \
  btop \
  just \
  google-tinos-fonts \
  google-cousine-fonts \
  google-arimo-fonts \
  google-crosextra-caladea-fonts \
  google-carlito-fonts \
  v4l2loopback
  
# TODO: remove this after xdg folders actually appear later on in fedora cosmic spin
sudo dnf in -y xdg-user-dirs
xdg-user-dirs-update
  
curl -f https://zed.dev/install.sh | sh
  
# delete fedora default flatpak repo and add flathub
sudo flatpak remote-delete fedora
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo flatpak override --socket=wayland

# install general flatpak apps
flatpak install flathub org.gtk.Gtk3theme.adw-gtk3 \
  org.gtk.Gtk3theme.adw-gtk3-dark \
  com.github.johnfactotum.Foliate \
  org.gnome.Loupe \
  io.github.celluloid_player.Celluloid \
  com.obsproject.Studio \
  com.obsproject.Studio.Plugin.Gstreamer \
  com.spotify.Client \
  com.discordapp.Discord \
  org.freedesktop.Platform \
  md.obsidian.Obsidian \
  org.gnome.Boxes \
  com.github.tchx84.Flatseal \
  com.github.wwmm.easyeffects \
  com.dec05eba.gpu_screen_recorder \
  io.missioncenter.MissionCenter \
  com.discordapp.Discord \
  org.freedesktop.Platform.ffmpeg-full
  
if [[ $NVIDIA_PROMPT == "y" || $NVIDIA_PROMPT == "Y" ]]
then
  sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda
fi

if [[ $GAME_PROMPT == "y" || $GAME_PROMPT == "Y" ]]
then
  sudo dnf in -y gamemode \
    steam-devices
  
  flatpak install flathub com.valvesoftware.Steam
  
  #mkdir $HOME/Games
fi

#if [[ $LAPTOP_PROMPT == "y" || $LAPTOP_PROMPT == "Y" ]]
#then
#fi

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source .bashrc

# install cosmic apps shown from cosmic-utils git repo
mkdir $HOME/CosmicApps

cd $HOME/CosmicApps && git clone https://github.com/wash2/cosmic_ext_bg_theme.git
make all && make install && make install-service

cd $HOME/CosmicApps && git clone https://github.com/cosmic-utils/clipboard-manager.git
cd clipboard-manager
just build-release
sudo just install

cd $HOME/CosmicApps && git clone https://github.com/cosmic-utils/observatory.git
cd observatory
just build-release
sudo just install

cd $HOME/CosmicApps && git clone https://github.com/D-Brox/cosmic-ext-applet-gamemode-status.git
cd cosmic-ext-applet-gamemode-status
just build-rpm
sudo just install-rpm

cd $HOME/CosmicApps && git clone https://github.com/leb-kuchen/cosmic-ext-applet-emoji-selector.git
cd cosmic-ext-applet-emoji-selector 
cargo b -r
sudo just install

#cd $HOME/CosmicApps && git clone https://github.com/PixelDoted/cosmic-ext-color-picker.git
#cd cosmic-ext-color-picker
#just build-release
#sudo just install

cd $HOME/CosmicApps && git clone https://github.com/cosmic-utils/calculator.git
cd calculator
just build-release
sudo just install

# setup git with credentials entered above
git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_USERNAME"

# setup fish dependencies and fish itself
curl -sS https://starship.rs/install.sh | sh

# install and set up ibm plex sans and mono fonts as default
source $HOME/dotfiles/SetupScripts/setup_ibm_plex_fonts.sh

# copy things from dotfiles .config to $HOME/.config
cp $HOME/dotfiles/BackedUpFiles/.config/starship.toml $HOME/.config/
cp -r $HOME/dotfiles/BackedUpFiles/.config/fontconfig $HOME/.config/
cp -r $HOME/dotfiles/BackedUpFiles/.config/fish $HOME/.config/
cp -r $HOME/dotfiles/BackedUpFiles/.config/cosmic $HOME/.config/

# add wifi powersave file to deactivate wifi powersave
sudo bash -c 'cat > /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf' <<-'EOF'
[connection]
wifi.powersave=2
EOF

sudo systemctl restart NetworkManager

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
