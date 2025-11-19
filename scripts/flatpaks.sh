#!/bin/bash
#SYSTEMFLATPAKS=(
#com.dec05eba.gpu_screen_recorder
#)

# clipboard manager via flatpak doesn't work due to a change in the protocol not supporting flatpaks
#COSMICFLATPAKS=(
#io.github.cosmic_utils.cosmic-ext-applet-clipboard-manager
#)

flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists --user cosmic https://apt.pop-os.org/cosmic/cosmic.flatpakrepo

FLATPAKS=(
com.dec05eba.gpu_screen_recorder
org.gtk.Gtk3theme.adw-gtk3
org.gtk.Gtk3theme.adw-gtk3-dark
#com.obsproject.Studio
#com.obsproject.Studio.Plugin.Gstreamer
com.spotify.Client
com.discordapp.Discord
org.freedesktop.Platform
md.obsidian.Obsidian
com.github.tchx84.Flatseal
io.missioncenter.MissionCenter
org.freedesktop.Platform.ffmpeg-full
io.github.nozwock.Packet
io.gitlab.theevilskeleton.Upscaler
dev.edfloreshz.CosmicTweaks
page.codeberg.libre_menu_editor.LibreMenuEditor
)

if [ -d /sys/module/nvidia ]
then
  FLATPAKS+=(
  com.vysp3r.ProtonPlus
  )

  # setup controller udev rules
  cd $HOME && git clone https://codeberg.org/fabiscafe/game-devices-udev.git
  sudo cp game-devices-udev/*.rules /etc/udev/rules.d/
  echo uinput | sudo tee /etc/modules-load.d/uinput.conf
  rm -rf $HOME/game-devices-udev

  cp -r $HOME/dotfiles/files/home/.config/MangoHud $HOME/.config/
fi

flatpak install --user flathub "${FLATPAKS[@]}"
#flatpak install flathub "${SYSTEMFLATPAKS[@]}"
#flatpak install cosmic "${COSMICFLATPAKS[@]}"

# flatpak overrides
flatpak override --user --socket=wayland
#sudo flatpak override io.github.celluloid_player.Celluloid --filesystem=xdg-config/mpv
