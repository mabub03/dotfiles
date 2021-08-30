#!/bin/bash
# set tw=0 to prevent auto-insert line breaks

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

sudo sysctl --load=/etc/sysctl.d/10-security.conf.conf

# blacklist Firewire SBP2
echo "blacklist firewire-sbp2" | sudo tee /etc/modprobe.d/blacklist.conf

# setup firewalld
sudo firewall-cmd --permanent --remove-port=1025-65535/udp
sudo firewall-cmd --permanent --remove-port=1025-65535/tcp
sudo firewall-cmd --permanent --remove-service=mdns
sudo firewall-cmd --permanent --remove-service=ssh
sudo firewall-cmd --permanent --remove-service=samba-client
sudo firewall-cmd --reload

# edit dnf.conf to make it faster and exclude gnome tour so updating doesn't reinstall it
# maximum of parallel downloads is 20
sudo echo 'max_parallel_downloads=15' | sudo tee -a /etc/dnf/dnf.conf
sudo echo 'fastestmirror=True' | sudo tee -a /etc/dnf/dnf.conf
sudo echo 'deltarpm=True' | sudo tee -a /etc/dnf/dnf.conf

# setup repos
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm 
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

sudo dnf update -y

# remove bloat
# totem is gnome videos
# cheese is gnome's webcam photo taking and video recording software
# ===============================================
# maybe remove if proven not needed:
# gnome-document-viewer rhythm box gnome boxes
# ===============================================
# Do not have whitespace at the end of the of the lines here or else it won't
# remove packages and launch them instead
sudo dnf remove -y \
  gnome-software \
  gnome-contacts \
  gnome-logs \
  gnome-maps \
  gnome-photos \
  totem \
  cheese \
  gedit \
  gnome-system-monitor \
  gnome-yelp \
  gnome-font-viewer \
  nano \
  gnome-boxes \
  abrt

# Install packages 
# Do not have whitespace at the end of the of the lines here or else it won't
# install packages and launch them instead
sudo dnf install -y \
  gnome-tweaks \
  gnome-extensions-app \
  neovim \
  "@C Development Tools And Libraries" \
  "@Development Tools" \
  "@Development Libraries" \
  util-linux-user \
  kitty \
  bpytop \
  libstdc++-static \
  foliate \
  neofetch \
  ninja-build \
  discord \
  brave-browser \
  timeshift \
  redhat-lsb-core \
  gnome-shell-extension-user-theme \
  gnome-shell-extension-appindicator \
  ffmpeg \
  mediainfo \
  piper \
  cmake \
  zsh

# install gnome-boxes from flathub since the one from fedora packages can't load
# gnome os nightly 
flatpak install flathub org.gnome.Boxes

# install Joplin
wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash

echo -n "Do you want to install Nvidia drivers? [y/N]"
read NVIDIA_PROMPT
if [[ $NVIDIA_PROMPT == "y" || $NVIDIA_PROMPT == "Y" ]]
then
  # install nvidia drivers
  sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda
fi

echo -n "Do you want to install Steam and Lutris? [y/N]"
read GAME_PROMPT
if [[ $GAME_PROMPT == "y" || $GAME_PROMPT == "Y" ]]
then
  sudo dnf install -y steam lutris wine winetricks
fi

# remove whatever isn't needed to clean up system just incase something got missed
flatpak remove --unused
sudo dnf autoremove -y

# enable auto TRIM
sudo systemctl enable fstrim.timer

# install fonts and update font cache
mkdir $HOME/.local/share/fonts
cd $HOME/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
unzip FiraCode.zip
unzip JetBrainsMono.zip
fc-cache -fv
cd $HOME

#install nvm for node 
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
source .bashrc
nvm install node

# add gtk and kitty settings from dotfiles to .config
cp -r $HOME/dotfiles/.config/gtk-3.0 $HOME/.config
cp -r $HOME/dotfiles/.config/kitty $HOME/.config

# setup neovim
source $HOME/dotfiles/setup_nvim.sh
source $HOME/dotfiles/lsp_server_install.sh

# install intellij toolbox for intellij ides
source $HOME/dotfiles/install_jetbrains_toolbox.sh

# Enable GNOME shell extensions
gsettings set org.gnome.shell disable-user-extensions false
gnome-extensions enable appindicatorsupport@rgcjonas.gmail.com
git clone https://github.com/aunetx/blur-my-shell
cd blur-my-shell
make install
cd $HOME

# disable background logo extension
gnome-extensions disable background-logo@fedorahosted.org

# install gnome themes, icons, and cursors
git clone https://github.com/cbrnix/Flatery.git
cd Flatery
./install.sh
cd $HOME

sudo dnf copr enable peterwu/rendezvous
sudo dnf install bibata-cursor-themes

#Enable tap to click (uncomment if you use touch screen)
#gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true

#Enable touchpad while typing (uncomment if you use touch screen) 
#gsettings set org.gnome.desktop.peripherals.touchpad disable-while-typing false

# add wifi powersave file to deactivate wifi powersave
# for some reason the commented out code below doesn't work so just gonna use
# echo messages and hope it works
#sudo bash -c 'cat > /etc/Networkmanager/conf.d/default-wifi-powersave-on.conf' <<-'EOF'
#[connection]
#wifi.powersave=2
#EOF
sudo echo "[connection]" >> /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf
sudo echo "wifi.powersave=2" >> /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf

#Randomize MAC address and restart NetworkManager
sudo bash -c 'cat > /etc/NetworkManager/conf.d/00-macrandomize.conf' <<-'EOF'
[device]
wifi.scan-rand-mac-address=yes

[connection]
wifi.cloned-mac-address=random
ethernet.cloned-mac-address=random
connection.stable-id=${CONNECTION}/${BOOT}
EOF

sudo systemctl restart NetworkManager

echo "Setup script has finished running"
echo "Restart your computer now for changes to take effect"

