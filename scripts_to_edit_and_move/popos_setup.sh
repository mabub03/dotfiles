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

# update pop os
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
  fish \
  eza \
  curl \
  wget \
  btop \
  build-essential \
  ubuntu-restricted-extras \
  fonts-croscore \
  fonts-crosextra-caladea \
  fonts-crosextra-carlito \
  v4l2loopback-source \
  v4l2loopback-utils \
  v4l2loopback-dkms

# install brave with the one command installer (see if it works and keep if it does to have less stuff in this file)  
curl -fsS https://dl.brave.com/install.sh | sh

# bottom command is for system flatpak repos while override --user is for user flatpak repos which pop uses
#sudo flatpak override --socket=wayland
flatpak override --user --socket=wayland

# install general flatpak apps
flatpak install org.gtk.Gtk3theme.adw-gtk3 \
  org.gtk.Gtk3theme.adw-gtk3-dark \
  com.github.johnfactotum.Foliate \
  org.gnome.Loupe \
  com.github.rafostar.Clapper \
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
  dev.edfloreshz.Calculator \
  flatpak install io.missioncenter.MissionCenter \
  org.freedesktop.Platform.ffmpeg-full

if [[ $GAME_PROMPT == "y" || $GAME_PROMPT == "Y" ]]
then
  sudo apt in -y gamemode \
    steam-devices \
    steam
  
  #flatpak install flathub com.valvesoftware.Steam
  
  #mkdir $HOME/Games
fi

#if [[ $LAPTOP_PROMPT == "y" || $LAPTOP_PROMPT == "Y" ]]
#then
#fi

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

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

# install and set up ibm plex sans and mono fonts as default
source $HOME/dotfiles/SetupScripts/setup_ibm_plex_fonts.sh

# moved to fish so just commented out incase i go back to zsh
# setup zsh dependencies and setup_configs.sh will move .zsh and related files where they need to be
#curl -sS https://starship.rs/install.sh | sh
#git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions
#cp $HOME/dotfiles/BackedUpFiles/.zshrc $HOME/.zshrc

# setup the cosmic material you/picom like app (https://github.com/wash2/cosmic_ext_bg_theme)
git clone https://github.com/wash2/cosmic_ext_bg_theme.git $HOME/cosmic-extensions/cosmic_ext_bg_theme
cd $HOME/cosmic-extensions/cosmic_ext_bg_theme
make all && make install && make install-service

# move user config things
#cp $HOME/dotfiles/BackedUpFiles/.config/starship.toml $HOME/.config/
cp -r $HOME/dotfiles/BackedUpFiles/.config/fish $HOME/.config/
cp -r $HOME/dotfiles/BackedUpFiles/.config/fontconfig $HOME/.config/
cp -r $HOME/dotfiles/BackedUpFiles/.config/cosmic $HOME/.config/

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

#change_shell() {
#  sudo chsh -s $(which fish) 
#}

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
