#!/bin/bash
# nvidia fix vram issues on wayland compositors like cosmic comp
# https://github.com/YaLTeR/niri/issues/1962

mkdir -p /etc/nvidia/nvidia-application-profiles-rc.d/
cp 50-limit-free-buffer-pool-in-wayland-compositors.json /etc/nvidia/nvidia-application-profiles-rc.d/

