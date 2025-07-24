#!/bin/bash
echo -n "What is your git email? "
read GIT_EMAIL

echo -n "What is your git username? "
read GIT_USERNAME

echo -n "Do you want to install Steam and other gaming utilities? [y/N]"
read GAME_PROMPT

pikman update && pikman upgrade -y

# install codecs metapackage and remove vlc because i don't like it
pikman install pika-codecs-meta -y
pikman remove vlc -y

# install printing drivers
pikman install cups cups-filters cups-pk-helper printer-driver-all -y

# install general packages
pikman install brave-browser \
  code \
  unrar \
  rar \
  eza \
  virt-manager \
  fish \
  build-essential \
  just \
  curl \
  wget \
  btop \
  gnome-disk-utility \
  fonts-croscore \
  fonts-crosextra-caladea \
  fonts-crosextra-carlito \
  v4l2loopback-source \
  obs-studio -y

# install apps that i would usually have as flatpaks on other distros
# might move them back to flatpak slowly idk will see how it goes
pikman install loupe \
  celluloid \
  easyeffects \
  gpu-screen-recorder-ui \
  foliate \
  discord \
  papers \
  pinta \
  gimp \
  gnome-font-viewer \
  spotify-client -y

# install gaming packages- pretty much everything from gaming metapackage except wine (since proton is better and umu exists), bottles, and lutris
if [[ $GAME_PROMPT == "y" || $GAME_PROMPT == "Y" ]]
then
  pikman install steam-launcher \
    heroic-games-launcher \
    protonplus \
    umu-launcher \
    nvidia-dlss-switcher \
    mangohud \
    goverlay \
    falcon \
    falcond \
    fabiscafe-devices \
    mesa-common-dev \
    mesa-vulkan-drivers \
    libegl1-mesa-dev \
    libgbm-dev \
    libgl1-mesa-dri \
    libglu1-mesa -y
    
  cp -r $HOME/dotfiles/BackedUpFiles/.config/MangoHud $HOME/.config/
fi

# setup flatpak repos
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists --user cosmic https://apt.pop-os.org/cosmic/cosmic.flatpakrepo

# install flatpak packages and setup permission overrides
pikman -fl -y install flathub org.gtk.Gtk3theme.adw-gtk3 \
  org.gtk.Gtk3theme.adw-gtk3-dark \
  io.missioncenter.MissionCenter \
  com.github.tchx84.Flatseal \
  com.github.neithern.g4music \
  io.github.nozwock.Packet \
  md.obsidian.Obsidian \
  io.gitlab.theevilskeleton.Upscaler -y

# install cosmic applets with flatpak
pikman -fl install cosmic co.uk.cappsy.CosmicAppletLogoMenu -y
#  io.github.cosmic_utils.cosmic-ext-applet-clipboard-manager

sudo flatpak override --socket=wayland
sudo flatpak override io.github.celluloid_player.Celluloid --filesystem=xdg-config/mpv

pikman install pika-cosmic-desktop -y

# maybe switch back to just installing via rustup if pika optimizations isn't that much more performant
pikman install rustc \
  cargo -y

# install zed
curl -f https://zed.dev/install.sh | sh

# setup git with credentials entered above
git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_USERNAME"

# install and set up ibm plex sans and mono fonts as default
source $HOME/dotfiles/SetupScripts/setup_ibm_plex_fonts.sh

# copy things from dotfiles .config to $HOME/.config
# cp $HOME/dotfiles/BackedUpFiles/.config/starship.toml $HOME/.config/
cp -r $HOME/dotfiles/BackedUpFiles/.config/fontconfig $HOME/.config/
cp -r $HOME/dotfiles/BackedUpFiles/.config/fish $HOME/.config/
cp -r $HOME/dotfiles/BackedUpFiles/.config/cosmic $HOME/.config/
rm $HOME/.config/cosmic/dont_include.txt

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
pikman install breeze-cursor-theme -y

sudo cp $HOME/dotfiles/CosmicCursorSetup/ChangedFiles/environment /etc/
sudo cp $HOME/dotfiles/CosmicCursorSetup/ChangedFiles/index.theme /usr/share/icons/

mkdir -p $HOME/.local/share/icons
sudo ln -s /usr/share/icons/default/ /home/toasty/.local/share/icons/default

gsettings set org.gnome.desktop.interface cursor-theme breeze_cursors

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


