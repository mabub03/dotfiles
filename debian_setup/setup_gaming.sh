#!/bin/bash
sudo apt install -y \
  gamemode \
  plasma-gamemode \
  steam-devices

flatpak install -y \
  flathub com.valvesoftware.Steam \
  org.yuzu_emu.yuzu
