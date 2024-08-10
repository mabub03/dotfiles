#!/bin/bash
echo -n "Do you want to install Steam and other gaming utilities? [y/N]"
read GAME_PROMPT

#echo -n "Is this a laptop? [y/N]"
#read LAPTOP_PROMPT

echo -n "What is your git email? "
read GIT_EMAIL

echo -n "What is your git username? "
read GIT_USERNAME

# TODO: can't properly add edge and vscode microsoft repos so find a way to curl or wget the deb file
# gets W: Failed to fetch https://packages.microsoft.com/repos/code/dists/stable/InRelease  Bad header line Bad header data [IP: 13.107.246.35 443]
# saw other people getting it on reddit also: 
# https://www.reddit.com/r/Ubuntu/comments/1bje80b/weird_apt_problem/
# vscode repos

# update fedora
sudo apt update && sudo apt upgrade -y

# remove certain things that i don't want or wouldn't work well via package manager compared to flatpak (like gnome-boxes)
sudo apt remove eog \
  totem \
  libtotem-plparser18 \
  libtotem0

# install general things
# on nvidia so video codecs don't matter too much (especially since video apps except browser are via flatpak) 
# so unsure about adding in ffmpeg-full and other codecs here right now, maybe if I do a non nvidia version
sudo apt install -y git \
  zsh \
  eza \
  curl \
  wget \
  btop \
  fonts-croscore \
  fonts-crosextra-caladea \
  fonts-crosextra-carlito \
  v4l2loopback-source \
  v4l2loopback-utils \
  v4l2loopback-dkms

# install general flatpak apps
flatpak install org.gtk.Gtk3theme.adw-gtk3 \
  org.gtk.Gtk3theme.adw-gtk3-dark \
  com.github.johnfactotum.Foliate \
  org.gnome.Loupe \
  com.github.rafostar.Clapper \
  com.obsproject.Studio \
	com.obsproject.Studio.Plugin.Gstreamer \
	com.spotify.Client \
	dev.vencord.Vesktop \
	org.freedesktop.Platform \
	md.obsidian.Obsidian \
	org.gnome.Boxes \
	com.github.tchx84.Flatseal \
	com.github.wwmm.easyeffects \
	org.freedesktop.Platform.ffmpeg-full

if [[ $GAME_PROMPT == "y" || $GAME_PROMPT == "Y" ]]
then
  sudo dnf in -y gamemode \
    steam-devices
  
  flatpak install flathub com.valvesoftware.Steam
fi

#if [[ $LAPTOP_PROMPT == "y" || $LAPTOP_PROMPT == "Y" ]]
#then
  # TODO: see what is better for battery tlp or gnome power profiles
  #sudo dnf install -y tlp
  #sudo systemctl enable tlp
  #Enable tap to click
#  gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
  # Enable disable touchpad while typing
  # gsettings set org.gnome.desktop.peripherals.touchpad disable-while-typing false
#fi

# setup git with credentials entered above
git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_USERNAME"

# setup zsh dependencies and setup_configs.sh will move .zsh and related files where they need to be
curl -sS https://starship.rs/install.sh | sh
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions
cp $HOME/dotfiles/BackedUpFiles/.zshrc $HOME/.zshrc

# move user config things
cp $HOME/dotfiles/BackedUpFiles/.config/starship.toml $HOME/.config/
cp -r $HOME/dotfiles/BackedUpFiles/.config/fontconfig $HOME/.config/

# install and set up ibm plex sans and mono fonts as default
source $HOME/dotfiles/SetupScripts/setup_ibm_plex_fonts.sh

# install and set up ocean sounds as default sounds
# source $HOME/dotfiles/SetupScripts/setup_ocean_sounds.sh

# install and setup phinger cursor as default cursor
# source $HOME/dotfiles/SetupScripts/setup_phinger_cursor.sh

# copy things from dotfiles .config to $HOME/.config
# maybe replace with symlink idk
# source $HOME/dotfiles/SetupScripts/setup_configs.sh

# add wifi powersave file to deactivate wifi powersave
sudo bash -c 'cat > /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf' <<-'EOF'
[connection]
wifi.powersave=2
EOF

#Randomize MAC address and restart NetworkManager
#sudo bash -c 'cat > /etc/NetworkManager/conf.d/00-macrandomize.conf' <<-'EOF'
#[device]
#wifi.scan-rand-mac-address=yes

#[connection]
#wifi.cloned-mac-address=stable
#ethernet.cloned-mac-address=stable
#connection.stable-id=${CONNECTION}/${BOOT}
#EOF

sudo systemctl restart NetworkManager

echo "Setup script has finished running"
echo "Restart your computer now for changes to take effect"
