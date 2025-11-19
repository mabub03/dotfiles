#!/bin/bash

if [ -d /sys/module/nvidia ]
then
  # setup controller udev rules
  cd $HOME && git clone https://codeberg.org/fabiscafe/game-devices-udev.git
  sudo cp game-devices-udev/*.rules /etc/udev/rules.d/
  echo uinput | sudo tee /etc/modules-load.d/uinput.conf
  rm -rf $HOME/game-devices-udev

  cp -r $HOME/dotfiles/files/home/.config/MangoHud $HOME/.config/
fi

curl -f https://zed.dev/install.sh | sh

# TODO:setup zram (still haven't decided if i wanna keep this config so it is commented out for now)
#sudo cp $HOME/dotfiles/files/etc/systemd/zram-generator.conf /etc/systemd/
#systemctl restart systemd-zram-setup@zram0.service

# setup sysctl optimizations (pop os zram /proc/sys/vm settings and steam deck & pop os /proc/sys/vm/max-map-count value)
# source just so I can use the variables in the file for the next conditional
source /etc/os-release

# PopOS has these settings so only run if the distro isn't PopOS
if [ "$ID" != "pop" ]; then
  sudo cp $HOME/dotfiles/etc/sysctl.d/99-vm-zram-params.conf /etc/sysctl.d/
  sudo cp $HOME/dotfiles/etc/sysctl.d/99-vm-max-map-count.conf /etc/sysctl.d/
  sudo sysctl -p /etc/sysctl.d/99-vm-zram-params.conf
  sudo sysctl -p /etc/sysctl.d/99-vm-max-map-count.conf
fi

# setup firefox and brave
sudo cp -r $HOME/dotfiles/etc/brave /etc/
#cp -r $HOME/dotfiles/files/home/.config/BraveSoftware /$HOME/.config/
sudo cp -r $HOME/dotfiles/etc/firefox /etc/
cp $HOME/dotfiles/home/.mozilla/firefox/default-release/user.js $HOME/.mozilla/firefox/*.default-release

# setup git with credentials entered above
git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_USERNAME"

# install and set up ibm plex sans and mono fonts as default
source $HOME/dotfiles/scripts/setup_ibm_plex_fonts.sh
source $HOME/dotfiles/cosmic_utilities/cosmic_cursor_setup/setup_cosmic_cursor.sh
# copy things from dotfiles .config to $HOME/.config
# cp $HOME/dotfiles/BackedUpFiles/.config/starship.toml $HOME/.config/
cp -r $HOME/dotfiles/home/.config/fontconfig $HOME/.config/
cp -r $HOME/dotfiles/home/.config/fish $HOME/.config/
cp -r $HOME/dotfiles/home/.config/cosmic $HOME/.config/

echo 'export COSMIC_DATA_CONTROL_ENABLED=1' | sudo tee /etc/profile.d/data_control_cosmic.sh > /dev/null

# add user to required groups
# remove whenever i stop getting razer mice
sudo gpasswd -a $USER plugdev

# set up services
# pop has sys76 scheduler and the gaming distros have ananicy so probably not needed here
#sudo systemctl enable --now ananicy-cpp

# hopefully just a temp service so bundling in the cp command also for easier removal later
mkdir $HOME/Pictures/Screenshots
cp -r $HOME/dotfiles/cosmic_utilities/screenshot_organizer/config/systemd $HOME/.config/
cp -r $HOME/dotfiles/cosmic_utilities/screenshot_organizer/local/bin $HOME/.local/
systemctl --user daemon-reload
systemctl --user enable --now cosmic_screenshot_organizer.service

# add wifi powersave file to deactivate wifi powersave
sudo bash -c 'cat > /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf' <<-'EOF'
[connection]
wifi.powersave=2
EOF

sudo systemctl restart NetworkManager

fish -c "set -U ELECTRON_OZONE_PLATFORM_HINT auto"
if [ -d /sys/module/nvidia ]
then
  fish -c "set -U __GL_SHADER_DISK_CACHE_SIZE 12884901888"
fi

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
