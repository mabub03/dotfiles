#!/bin/bash

# Remove comment if you only want split clock and not full fluent and remove the git links below
#PLASMOIDS_DIR="$HOME/.local/share/plasma/plasmoids"

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
#sudo firewall-cmd --permanent --remove-service=samba-client
sudo firewall-cmd --reload

# edit dnf.conf to make it faster and exclude gnome tour so updating doesn't reinstall it
# maximum of parallel downloads is 20
sudo echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
sudo echo 'fastestmirror=True' | sudo tee -a /etc/dnf/dnf.conf

# setup repos
# enable flathub repo and disable fedora curated flatpak repo
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
sudo flatpak remote-modify --enable flathub
sudo flatpak remote-modify --disable fedora
sudo flatpak remote-modify --enable flathub-beta
# rpm fusion free and non free (don't need in fedora 35 just when setting up after install click turn on 3rd party repos button)
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# brave repos NOTICE: (test out flathub and if works remove this)
#sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
#sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

# vscode repos
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf update -y

# remove kgpg kcharselect plasma-emojier?????
sudo dnf remove -y \
  dnfdragora \
  dragon \
  kmahjongg \
  kmines \
  kpat \
  konversation \
  gnome-abrt \
  abrt \
  kamoso \
  kmouth \
  kmousetool \
  kmag \
  libreoffice-writer \
  libreoffice-calc \
  libreoffice-impress \
  firefox \
  kcalc \
  kfind \
  kolourpaint \
  kwrite

# remove akonadi
sudo dnf remove -y \*akonadi\*

# in vm ffmpeg gave error due to conflicts with libswscale-free
# due to not wanting to bother with this just gonna also install vlc as a flatpak
sudo dnf install -y \
  kate \
  neovim \
  "@C Development Tools And Libraries" \
  "@Development Tools" \
  "@Development Libraries" \
  meson \
  clang \
  util-linux-user \
  libstdc++-static \
  neofetch \
  ninja-build \
  timeshift \
  redhat-lsb-core \
  mediainfo \
  cmake \
  code \
  zsh \
  python3-pip \
  openssl \
  sassc \
  btop
#  brave-browser

# install gnome-boxes from flathub since the one from fedora packages can't load gnome os nightly
flatpak install -y flathub \
  org.libreoffice.LibreOffice \
  com.github.tchx84.Flatseal \
  com.spotify.Client \
  org.freedesktop.Platform.ffmpeg-full \
  org.mozilla.firefox \
  org.mozilla.Thunderbird \
  org.videolan.VLC
  com.brave.Browser

flatpak install -y flathub-beta com.discordapp.DiscordCanary

# enable firefox and thunderbird to use wayland
flatpak --user override --socket=wayland --env=MOZ_ENABLE_WAYLAND=1 --device=dri --filesystem=xdg-run/pipewire-0 org.mozilla.firefox
flatpak --user override --socket=wayland --env=MOZ_ENABLE_WAYLAND=1 --device=all --device=dri dri org.mozilla.Thunderbird
flatpak --user override --socket=wayland com.brave.Browser

echo -n "Do you want to install Nvidia drivers? [y/N]"
read NVIDIA_PROMPT
if [[ $NVIDIA_PROMPT == "y" || $NVIDIA_PROMPT == "Y" ]]
then
  # install nvidia drivers
  #sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda
  echo "follow the instructions to setup nvidia with secureboot here: https://blog.monosoul.dev/2022/05/17/automatically-sign-nvidia-kernel-module-in-fedora-36/"
fi

echo -n "Do you want to install Steam and other gaming utilities? [y/N]"
read GAME_PROMPT
if [[ $GAME_PROMPT == "y" || $GAME_PROMPT == "Y" ]]
then
  # might need to add lutris, wine, and winetricks if bottles isn't enough
  # add steam to dnf install if flatpak version isn't good enough
  sudo dnf install -y gamemode
  flatpak install flathub com.valvesoftware.Steam
fi

echo -n "Do you use a laptop? [y/N]"
read LAPTOP_PROMPT
if [[ $LAPTOP_PROMPT == "y" || $LAPTOP_PROMPT == "Y" ]]
then
  sudo dnf install -y tlp
  sudo systemctl enable tlp
fi

# remove whatever isn't needed to clean up system just in case something got missed
flatpak remove --unused
sudo dnf autoremove -y

#install volta for a node manager
curl https://get.volta.sh | bash
source .bashrc
volta install node

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# setup neovim
#source $HOME/dotfiles/setup_nvim.sh

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

# Make Fedora fonts better
sudo ln -fs /usr/share/fontconfig/conf.avail/10-autohint.conf /etc/fonts/conf.d
sudo ln -fs /usr/share/fontconfig/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d/
sudo ln -fs /usr/share/fontconfig/conf.avail/10-hinting-slight.conf /etc/fonts/conf.d/
sudo ln -fs /usr/share/fontconfig/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d/
sudo ln -fs /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/
cp $HOME/dotfiles/.config/fontconfig/fonts.conf .config/fontconfig/fonts.conf
# move x resources to the proper place
# remove when x is no longer used
cp $HOME/dotfiles/.Xresources $HOME/.Xresources
fc-cache -Ev

# Move .config items
cp -r $HOME/dotfiles/.config/btop $HOME/.config/btop
cp -r $HOME/dotfiles/.config/gtk-3.0 $HOME/.config/gtk-3.0
cp -r $HOME/dotfiles/.config/gtk-4.0 $HOME/.config/gtk-4.0
cp -r $HOME/dotfiles/.config/vlc $HOME/.var/app/org.videolan.VLC/config/vlc

# remove akonadi files
rm -rf $HOME/.config/akonadi
rm -rf $HOME/.local/share/akonadi
rm -rf $HOME/.local/share/akonadi_migration_agent

#[[ ! -d ${PLASMOIDS_DIR} ]] && mkdir -p ${PLASMOIDS_DIR}
#git clone https://github.com/vinceliuice/Fluent-kde.git
#cp -r Fluent-kde/plasma/plasmoids/org.kde.plasma.splitdigitalclock ${PLASMOIDS_DIR}
#rm -rf Fluent-kde

# maybe transfer vlc config for native scrollbars and stuff
# maybe transfer panel just cause more laziness

# enable auto TRIM
sudo systemctl enable fstrim.timer

# add wifi powersave file to deactivate wifi powersave
sudo bash -c 'cat > /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf' <<-'EOF'
[connection]
wifi.powersave=2
EOF

sudo systemctl restart NetworkManager

echo "Setup script has finished running"
echo "Restart your computer now for changes to take effect"
