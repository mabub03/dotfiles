#!/bin/bash
echo -n "Do you want to install Nvidia drivers? [y/N]"
read NVIDIA_PROMPT

echo -n "Do you want to install Steam and other gaming utilities? [y/N]"
read GAME_PROMPT

echo -n "Is this a laptop? [y/N]"
read LAPTOP_PROMPT

echo -n "What is your git email? "
read GIT_EMAIL

echo -n "What is your git username? "
read GIT_USERNAME

# rpm fusion free and non free (sadly still need since fedora 35+ doesn't include the full rpm fusion repos just a couple packages from it)
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# microsoft edge stable repos
# TODO: FIX THIS 
# Unknown argument "--add-repo" for command "config-manager". Add "--help" for more information about the arguments.
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge
sudo mv /etc/yum.repos.d/packages.microsoft.com_yumrepos_edge.repo /etc/yum.repos.d/microsoft-edge-stable.repo

# vscode repos
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

# update fedora
sudo dnf up -y

# remove certain things that i don't want or wouldn't work well via package manager compared to flatpak (like gnome-boxes)
sudo dnf rm -y gnome-boxes 

# install general things
# on nvidia so video codecs don't matter too much (especially since video apps except browser are via flatpak) 
# so unsure about adding in ffmpeg-full and other codecs here right now, maybe if I do a non nvidia version
sudo dnf in -y git \
  zsh \
  eza \
  curl \
  wget \
  code \
  gnome-tweaks \
  btop \
  google-tinos-fonts \
  google-cousine-fonts \
  google-arimo-fonts \
  google-crosextra-caladea-fonts \
  google-carlito-fonts \
  gnome-shell-extension-appindicator \
  adw-gtk3-theme \
  v4l2loopback \
  microsoft-edge-stable
 
# delete fedora default flathub remote since i don't like system wide flatpak since screw passwords and add --user version
sudo flatpak remote-delete fedora
flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# install general flatpak apps
flatpak install org.gtk.Gtk3theme.adw-gtk3 \
	org.gtk.Gtk3theme.adw-gtk3-dark \
	com.github.johnfactotum.Foliate \
	com.github.rafostar.Clapper \
	com.mattjakeman.ExtensionManager \
	com.obsproject.Studio.Plugin.Gstreamer \
	com.spotify.Client \
	dev.vencord.Vesktop \
	org.freedesktop.Platform \
	md.obsidian.Obsidian \
	org.gnome.Boxes \
	com.github.tchx84.Flatseal \
	com.github.wwmm.easyeffects \
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
  
  mkdir $HOME/Games
fi

if [[ $LAPTOP_PROMPT == "y" || $LAPTOP_PROMPT == "Y" ]]
then
  # TODO: see what is better for battery tlp or gnome power profiles
  #sudo dnf install -y tlp
  #sudo systemctl enable tlp
  #Enable tap to click
  gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
  # Enable disable touchpad while typing
  # gsettings set org.gnome.desktop.peripherals.touchpad disable-while-typing false
fi

# setup git with credentials entered above
git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_USERNAME"

# setup zsh dependencies and setup_configs.sh will move .zsh and related files where they need to be
curl -sS https://starship.rs/install.sh | sh
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions

# install and set up ibm plex sans and mono fonts as default
source $HOME/dotfiles/SetupScripts/setup_ibm_plex_fonts.sh
# install and set up ocean sounds as default sounds
source $HOME/dotfiles/SetupScripts/setup_ocean_sounds.sh
# install and setup phinger cursor as default cursor
source $HOME/dotfiles/SetupScripts/setup_phinger_cursor.sh

# copy templates from dotfiles to $HOME/Templates
source $HOME/dotfiles/SetupScripts/setup_templates.sh

# copy things from dotfiles .config to $HOME/.config
# maybe replace with symlink idk
source $HOME/dotfiles/SetupScripts/setup_configs.sh

# setup gnome via gsettings and disable background-logo extension
source $HOME/dotfiles/SetupScripts/setup_gnome_settings.sh

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
