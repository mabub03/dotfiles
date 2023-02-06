#!/bin/bash
# disable ptrace
sudo cp /usr/lib/sysctl.d/10-default-yama-scope.conf /etc/sysctl.d/
sudo sed -i 's/kernel.yama.ptrace_scope = 0/kernel.yama.ptrace_scope = 3/g' /etc/sysctl.d/10-default-yama-scope.conf

sudo sysctl --load=/etc/sysctl.d/10-default-yama-scope.conf

# security kernel settings
# restrict unprivileged access to kernel syslog
sudo bash -c 'cat > /etc/sysctl.d/51-dmesg-restrict.conf' <<-'EOF'
kernel.dmesg_restrict = 1
EOF

sudo sysctl --load=/etc/sysctl.d/51-dmesg-restrict.conf

sudo bash -c 'cat > /etc/sysctl.d/51-kptr-restrict.conf' <<-'EOF'
kernel.kptr_restrict = 2
EOF

sudo sysctl --load=/etc/sysctl.d/51-kptr-restrict.conf

sudo bash -c 'cat > /etc/sysctl.d/51-kexec-restrict.conf' <<-'EOF'
kernel.kexec_load_disabled = 1
EOF

sudo sysctl --load=/etc/sysctl.d/51-kexec-restrict.conf

sudo bash -c 'cat > /etc/sysctl.d/10-security.conf' <<-'EOF'
net.core.bpf_jit_harden = 2
EOF

sudo sysctl --load=/etc/sysctl.d/10-security.conf

# blacklist Firewire SBP2
echo "blacklist firewire-sbp2" | sudo tee /etc/modprobe.d/blacklist.conf

# setup firewalld
sudo firewall-cmd --permanent --remove-port=1025-65535/udp
sudo firewall-cmd --permanent --remove-port=1025-65535/tcp
sudo firewall-cmd --permanent --remove-service=mdns
#sudo firewall-cmd --permanent --remove-service=ssh
sudo firewall-cmd --permanent --remove-service=samba-client
sudo firewall-cmd --reload

# edit dnf.conf to make it faster and exclude gnome tour so updating doesn't reinstall it
# maximum of parallel downloads is 20
sudo echo 'max_parallel_downloads=15' | sudo tee -a /etc/dnf/dnf.conf
sudo echo 'fastestmirror=True' | sudo tee -a /etc/dnf/dnf.conf
sudo echo 'deltarpm=True' | sudo tee -a /etc/dnf/dnf.conf

# setup repos
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
# rpm fusion free and non free (don't need in fedora 35 just when setting up after install click turn on 3rd party repos button)
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm 

# enable google chrome repos
#sudo dnf install fedora-workstation-repositories
#sudo dnf config-manager --set-enabled google-chrome

# microsoft edge beta repos
#sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
#sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge
#sudo mv /etc/yum.repos.d/packages.microsoft.com_yumrepos_edge.repo /etc/yum.repos.d/microsoft-edge-stable.repo

# brave repos
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

# vscode repos
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf update -y

# Do not have whitespace at the end of the of the lines here or else it won't
# Remove packages and some of these will be reinstalled with flatpak
sudo dnf remove -y \
  evince \
  gnome-contacts \
  gnome-logs \
  gnome-maps \
  gnome-photos \
  totem \
  cheese \
  gnome-system-monitor \
  gnome-yelp \
  gnome-boxes \
  sassc \
  libsass \
  rhythmbox \
  libreoffice-writer \
  libreoffice-calc \
  libreoffice-impress \
  firefox \
  abrt

# Install packages 
# Do not have whitespace at the end of the of the lines here or else it won't
# install packages and launch them instead
sudo dnf install -y \
  gnome-tweaks \
  neovim \
  "@C Development Tools And Libraries" \
  "@Development Tools" \
  "@Development Libraries" \
  meson \
  clang \
  gtk3-devel \
  util-linux-user \
  libstdc++-static \
  neofetch \
  ninja-build \
  timeshift \
  redhat-lsb-core \
  ffmpeg \
  mediainfo \
  cmake \
  code \
  zsh \
  python3-pip \
  openssl \
  sassc \
  yubikey-manager \
  yubikey-manager-qt \
  btop \
  brave-browser
#  google-chrome-stable \
#  microsoft-edge-stable

# enable flathub repo and disable fedora curated flatpak repo
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
sudo flatpak remote-modify --enable flathub
sudo flatpak remote-modify --disable fedora
sudo flatpak remote-modify --enable flathub-beta

# install gnome-boxes from flathub since the one from fedora packages can't load gnome os nightly 
flatpak install -y flathub \
  org.gnome.Boxes \
  org.libreoffice.LibreOffice \
  com.mattjakeman.ExtensionManager\
  org.freedesktop.Piper \
  com.github.tchx84.Flatseal \
  com.spotify.Client \
  com.github.johnfactotum.Foliate \
  org.freedesktop.Platform.ffmpeg-full \
  org.mozilla.firefox \
  org.mozilla.Thunderbird \
  com.github.rafostar.Clapper

flatpak install -y flathub-beta com.discordapp.DiscordCanary

# enable firefox and thunderbird to use wayland
flatpak --user override --socket=wayland --env=MOZ_ENABLE_WAYLAND=1 --device=dri --filesystem=xdg-run/pipewire-0 org.mozilla.firefox
flatpak --user override --socket=wayland --env=MOZ_ENABLE_WAYLAND=1 --device=all --device=dri dri org.mozilla.Thunderbird

echo -n "Do you want to install Nvidia drivers? [y/N]"
read NVIDIA_PROMPT
if [[ $NVIDIA_PROMPT == "y" || $NVIDIA_PROMPT == "Y" ]]
then
  # install nvidia drivers
  #sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda
  echo "follow the instructions to setup nvidia with secureboot here: "
fi

echo -n "Do you want to install Steam and Lutris? [y/N]"
read GAME_PROMPT
if [[ $GAME_PROMPT == "y" || $GAME_PROMPT == "Y" ]]
then
  # might need to add lutris, wine, and winetricks if bottles isn't enough
  sudo dnf install -y steam gamemode
fi

echo -n "Do you use a laptop? [y/N]"
read LAPTOP_PROMPT
if [[ $LAPTOP_PROMPT == "y" || $LAPTOP_PROMPT == "Y" ]]
then
  sudo dnf install -y tlp
  sudo systemctl enable tlp
  #Enable tap to click
  gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
  # Enable disable touchpad while typing
  # gsettings set org.gnome.desktop.peripherals.touchpad disable-while-typing false
fi

# remove whatever isn't needed to clean up system just in case something got missed
flatpak remove --unused
sudo dnf autoremove -y

# enable auto TRIM
sudo systemctl enable fstrim.timer

# Move .config items
cp -r $HOME/dotfiles/.config/btop $HOME/.config/btop
cp -r $HOME/dotfiles/.config/gtk-3.0 $HOME/.config/gtk-3.0
cp -r $HOME/dotfiles/.config/gtk-4.0 $HOME/.config/gtk-4.0

# install fonts and update font cache
mkdir $HOME/.local/share/fonts
cd $HOME/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
unzip FiraCode.zip
unzip JetBrainsMono.zip
rm -rf FiraCode.zip
rm -rf JetBrainsMono.zip
fc-cache -fv
cd $HOME

# install gtk 3 libadwaita theme
git clone https://github.com/lassekongo83/adw-gtk3.git
cd adw-gtk3
meson build
sudo ninja -C build install

#install volta for a node manager
curl https://get.volta.sh | bash
source .bashrc
volta install node

# setup neovim
source $HOME/dotfiles/setup_nvim.sh

# install intellij toolbox for intellij ides
#source $HOME/dotfiles/install_jetbrains_toolbox.sh

# Enable GNOME shell extensions
cd $HOME
mkdir gnome-extensions-repos
cd gnome-extensions-repos
git clone https://github.com/aunetx/blur-my-shell
cd blur-my-shell
make install
cd $HOME/gnome-extensions-repos
git clone https://github.com/ubuntu/gnome-shell-extension-appindicator.git
cd gnome-shell-extension-appindicator
meson gnome-shell-extension-appindicator /tmp/g-s-appindicators-build
ninja -C /tmp/g-s-appindicators-build install
cd $HOME

# disable background logo extension
gnome-extensions disable background-logo@fedorahosted.org

# Make Fedora fonts better
# add a if this file doesn't exist create a symlink block here
#sudo ln -fs /usr/share/fontconfig/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d
#sudo ln -fs /usr/share/fontconfig/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d
sudo ln -fs /usr/share/fontconfig/conf.avail/10-autohint.conf /etc/fonts/conf.d
sudo ln -s /usr/share/fontconfig/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d/  
sudo ln -s /usr/share/fontconfig/conf.avail/10-hinting-slight.conf /etc/fonts/conf.d/  
sudo ln -s /usr/share/fontconfig/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d/  
sudo ln -s /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/ 
gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'
gsettings set org.gnome.desktop.interface font-hinting 'slight'
cp $HOME/dotfiles/.config/fontconfig/fonts.conf .config/fontconfig/fonts.conf 
# move x resources to the proper place
# remove when x is no longer used
cp $HOME/dotfiles/.Xresources $HOME/.Xresources
fc-cache -Ev

# setup chrome desktop parameters
#cp /usr/share/applications/google-chrome.desktop ~/.local/share/applications/google-chrome.desktop
#sed -i 's;/usr/bin/google-chrome-stable;/usr/bin/google-chrome-stable --enable-features=WebUIDarkMode,VaapiVideoDecoder,VaapiVideoEncoder,CanvasOopRasterization --disable-gpu-driver-workarounds --use-gl=desktop --force-dark-mode;g' ~/.local/share/applications/google-chrome.desktop

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

