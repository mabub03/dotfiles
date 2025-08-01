#!/bin/bash
# nvidia fix vram issues on wayland compositors like cosmic comp
# https://github.com/YaLTeR/niri/issues/1962

sudo mkdir -p /etc/nvidia/nvidia-application-profiles-rc.d/
sudo cp 50-limit-free-buffer-pool-in-wayland-compositors.json /etc/nvidia/nvidia-application-profiles-rc.d/
