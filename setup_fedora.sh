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
sudo echo 'max_parallel_downloads=20' | sudo tee -a /etc/dnf/dnf.conf
sudo echo 'fastestmirror=True' | sudo tee -a /etc/dnf/dnf.conf
sudo echo 'deltarpm=True' | sudo tee -a /etc/dnf/dnf.conf

# setup repos
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# rpm fusion free and non free (don't need in fedora 35 just when setting up after install click turn on 3rd party repos button)
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm 
# brave
#sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
#sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

# microsoft edge beta repos
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge
sudo mv /etc/yum.repos.d/packages.microsoft.com_yumrepos_edge.repo /etc/yum.repos.d/microsoft-edge-beta.repo

# vscode repos
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf update -y

# Do not have whitespace at the end of the of the lines here or else it won't
# Remove packages and some of these will be reinstalled with flatpak
sudo dnf remove -y \
  gnome-calendar \
  eog \
  evince \
  gnome-calculator \
  gnome-clocks \
  gnome-contacts \
  gnome-logs \
  gnome-maps \
  gnome-photos \
  totem \
  cheese \
  gedit \
  gnome-system-monitor \
  gnome-weather \
  gnome-yelp \
  gnome-font-viewer \
  nano \
  gnome-boxes \
  sassc \
  libsass \
  rhythmbox \
  libreoffice-writer \
  libreoffice-calc \
  libreoffice-impress \
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
  clang \
  gtk3-devel \
  util-linux-user \
  bpytop \
  libstdc++-static \
  foliate \
  neofetch \
  ninja-build \
  timeshift \
  redhat-lsb-core \
  gnome-shell-extension-user-theme \
  gnome-shell-extension-appindicator \
  ffmpeg \
  mediainfo \
  cmake \
  code \
  zsh \
  discord \
  python3-pip \
  openssl \
  microsoft-edge-beta
  #brave-browser

# install gnome-boxes from flathub since the one from fedora packages can't load gnome os nightly 
flatpak install -y flathub \
  org.gnome.Boxes \
  org.gnome.Weather \
  org.videolan.VLC \
  org.gnome.Calander \
  org.kde.krita \
  org.gnome.eog \
  org.gnome.Rythmbox3 \
  org.libreoffice.LibreOffice \
  org.gnome.Evince \
  org.gnome.Calculator \
  org.gnome.clocks \
  org.gnome.Extensions \
  org.gnome.Evolution \
  org.kde.kpat \
  org.freedesktop.Piper \
  org.supertuxproject.SuperTux \
  net.cozic.joplin_desktop \
  com.github.tchx84.Flatseal \
  com.spotify.Client \
  com.bitwarden \
  com.jgraph.drawio
  
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

echo -n "Do you use a laptop? [y/N]"
read $LAPTOP_PROMPT
if [[ $LAPTOP_PROMPT == "y" || $LAPTOP_PROMPT == "Y" ]]
then
  sudo dnf install -y tlp
  sudo systemctl enable tlp
  #Enable tap to click
  gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
  # Enable disable touchpad while typing
  # gsettings set org.gnome.desktop.peripherals.touchpad disable-while-typing false
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
rm -rf FiraCode.zip
rm -rf JetBrainsMono.zip
fc-cache -fv
cd $HOME

#install volta for a node manager
curl https://get.volta.sh | bash
source .bashrc
volta install node

# setup neovim
source $HOME/dotfiles/setup_nvim.sh

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

# add wifi powersave file to deactivate wifi powersave
# for some reason the commented out code below doesn't work so just gonna use
# echo messages and hope it works
#sudo bash -c 'cat > /etc/Networkmanager/conf.d/default-wifi-powersave-on.conf' <<-'EOF'
#[connection]
#wifi.powersave=2
#EOF
sudo echo "[connection]" >> /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf
sudo echo "wifi.powersave = 2" >> /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf

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

