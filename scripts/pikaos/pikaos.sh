#!/bin/bash
echo -n "What is your git email? "
read GIT_EMAIL

echo -n "What is your git username? "
read GIT_USERNAME

source $HOME/dotfiles/scripts/pikaos/packages.sh
source $HOME/dotfiles/scripts/pikaos/flatpak.sh

# setup git with credentials entered above
git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_USERNAME"

# setup firefox and brave
#sudo cp -r $HOME/dotfiles/etc/brave /etc/
#cp -r $HOME/dotfiles/files/home/.config/BraveSoftware /$HOME/.config/
#sudo cp -r $HOME/dotfiles/etc/firefox /etc/
#cp $HOME/dotfiles/home/.mozilla/firefox/default-release/user.js $HOME/.mozilla/firefox/*.default-release

# install and set up ibm plex sans and mono fonts as default
source $HOME/dotfiles/scripts/setup_ibm_plex_fonts.sh

# install rust
rustup toolchain install stable && source $HOME/.bashrc

# move services
cp -r $HOME/dotfiles/home/.config/systemd $HOME/.config/systemd
cp -r $HOME/dotfiles/home/.local/bin $HOME/.local/bin
systemctl --user daemon-reload

cp -r $HOME/dotfiles/home/.config/environment.d/ $HOME/.config
cp -r $HOME/dotfiles/home/.config/fontconfig $HOME/.config/
#cp -r $HOME/dotfiles/home/.config/fish $HOME/.config/
cp -r $HOME/dotfiles/home/.config/cosmic $HOME/.config/
mkdir -p $HOME/.var/app/dev.edfloreshz.CosmicTweaks/data/dev.edfloreshz.CosmicTweaks/layouts/
cp -r $HOME/dotfiles/home/.var/app/dev.edfloreshz.CosmicTweaks/data/dev.edfloreshz.CosmicTweaks/layouts/ 

# add user to required groups
# remove whenever i stop getting razer mice
sudo gpasswd -a $USER plugdev

# if the system has proton plus installed then enable the service
if command -v protonplus &> /dev/null || flatpak list --app | grep -iq "ProtonPlus"; then
  systemctl --user enable --now proton_plus_update.timer

# add wifi stable ssid mac addr randomization and disable wifi powersave
sudo cp $HOME/dotfiles/etc/NetworkManager/conf.d/* /etc/NetworkManager/conf.d/
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