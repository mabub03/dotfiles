#!/bin/bash
#SYSTEMFLATPAKS=(
#com.dec05eba.gpu_screen_recorder
#)

COSMICFLATPAKS=(
io.github.hepp3n.kdeconnect
io.github.k33wee.clippy-land
)

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists --user cosmic https://apt.pop-os.org/cosmic/cosmic.flatpakrepo

FLATPAKS=(
#com.dec05eba.gpu_screen_recorder
org.gtk.Gtk3theme.adw-gtk3
org.gtk.Gtk3theme.adw-gtk3-dark
#com.obsproject.Studio
#com.obsproject.Studio.Plugin.Gstreamer
#com.spotify.Client
#com.discordapp.Discord
org.freedesktop.Platform
md.obsidian.Obsidian
com.github.tchx84.Flatseal
io.missioncenter.MissionCenter
org.freedesktop.Platform.ffmpeg-full
io.github.nozwock.Packet
io.gitlab.theevilskeleton.Upscaler
dev.edfloreshz.CosmicTweaks
page.codeberg.libre_menu_editor.LibreMenuEditor
com.github.neithern.g4music
com.github.PintaProject.Pinta
com.github.rafostar.Clapper
com.github.rafostar.Clapper.Enhancers
)

flatpak install --user flathub "${FLATPAKS[@]}"
#flatpak install flathub "${SYSTEMFLATPAKS[@]}"
flatpak install --user cosmic "${COSMICFLATPAKS[@]}"

# flatpak overrides
flatpak override --user --socket=wayland
#sudo flatpak override io.github.celluloid_player.Celluloid --filesystem=xdg-config/mpv
