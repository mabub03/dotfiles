#!/bin/bash
#TODO: Add firewall either ufw, firewalld, or opensuse default

#TODO: Fix this
# disable ptrace
#sudo cp /usr/lib/sysctl.d/10-default-yama-scope.conf /etc/sysctl.d/
#sudo sed -i 's/kernel.yama.ptrace_scope = 0/kernel.yama.ptrace_scope = 3/g' /etc/sysctl.d/10-default-yama-scope.conf

#sudo sysctl --load=/etc/sysctl.d/10-default-yama-scope.conf

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

#TODO: Fix this
#sudo bash -c 'cat > /etc/sysctl.d/10-security.conf' <<-'EOF'
#net.core.bpf_jit_harden = 2
#EOF

#sudo sysctl --load=/etc/sysctl.d/10-security.conf.conf

# blacklist Firewire SBP2
echo "blacklist firewire-sbp2" | sudo tee /etc/modprobe.d/blacklist.conf

sudo zypper update -y

sudo zypper install -t pattern devel_C_C++
sudo zypper install -t pattern devel_basis
sudo zypper install -t pattern lamp_server

sudo zypper install -y \
  kio-gdrive \
  neofetch \
  zsh \
  pipewire \
  pipewire-pulseaudio \
  pipewire-alsa \
  neovim \
  foliate \
  ninja \
  dkms \
  cmake \
  ffmpeg \
  mediainfo \
  clang \
  timeshift \
  gtk3-devel \
  kpat \
  mpv \
  piper \
  discord \
  libvirt \
  qemu virt-manager \
  libvirt-daemon-driver-qemu \
  vlc \
  qemu-kvm

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo zypper addrepo https://packages.microsoft.com/yumrepos/vscode vscode
sudo zypper refresh
sudo zypper install code

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo zypper ar https://packages.microsoft.com/yumrepos/edge microsoft-edge-stable
sudo zypper refresh
sudo zypper install microsoft-edge-stable

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub \
  com.jgraph.drawio \
  com.bitwarden \
  com.github.tchx84.Flatseal \
  com.github.akiraux.akira \
  com.spotify.Client

echo -n "Do you want to install Steam and Lutris? [y/N]"
read GAME_PROMPT
if [[ $GAME_PROMPT == "y" || $GAME_PROMPT == "Y" ]]
then
  sudo zypper install -y \
    steam \
    lutris \
    wine \
    winetricks
else
  continue
fi

echo -n "Do you want to install Nvidia drivers? [y/N]"
read NVIDIA_PROMPT
if [[ $NVIDIA_PROMPT == "y" || $NVIDIA_PROMPT == "Y" ]]
then
  # install nvidia drivers
  sudo zypper addrepo --refresh https://download.nvidia.com/opensuse/tumbleweed NVIDIA
  sudo zypper refresh
  sudo zypper install -y \
    x11-video-nvidiaG05 \
    libva-vdpau-driver \
    libvdpau_va_gl1 \
    libvdpau_trace1
fi

# remove whatever isn't needed to clean up system just incase something got missed
flatpak remove --unused
sudo zypper packages --orphaned

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

curl https://get.volta.sh | bash
source .bashrc
volta install node

# setup neovim
source $HOME/dotfiles/setup_nvim.sh

# install intellij toolbox for intellij ides
source $HOME/dotfiles/install_jetbrains_toolbox.sh

sudo touch /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf
sudo bash -c 'cat > /etc/Networkmanager/conf.d/default-wifi-powersave-on.conf' <<-'EOF'
[connection]
wifi.powersave=2
EOF
#sudo echo "[connection]" >> /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf
#sudo echo "wifi.powersave = 2" >> /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf

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
