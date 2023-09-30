#!/bin/bash
sudo apt install flatpak plasma-discover-backend-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
flatpak remote-modify --enable flathub
flatpak remote-modify --enable flathub-beta

# TODO: add the kde userscope apps here & search up which system apps should be via flatpak instead of apt
flatpak install -y flathub \
  org.libreoffice.LibreOffice \
  com.github.tchx84.Flatseal \
  com.spotify.Client \
  org.freedesktop.Platform.ffmpeg-full \
  org.mozilla.firefox \
  org.mozilla.Thunderbird \
  org.kde.haruna \
  org.kde.arianna \
  org.kde.akregator \
  org.kde.elisa \
  org.kde.okular \
  org.kde.gwenview \
  org.kde.kid3 \
  org.kde.krdc \
  com.brave.Browser

flatpak install -y flathub-beta com.discordapp.DiscordCanary

# enable firefox and thunderbird to use wayland
flatpak --user override --socket=wayland --env=MOZ_ENABLE_WAYLAND=1 --device=dri --filesystem=xdg-run/pipewire-0 org.mozilla.firefox
flatpak --user override --socket=wayland --env=MOZ_ENABLE_WAYLAND=1 --device=dri --filesystem=xdg-run/pipewire-0 org.mozilla.Thunderbird
