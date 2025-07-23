#!/bin/bash
sudo dnf copr enable bieszczaders/kernel-cachyos
sudo dnf copr enable bieszczaders/kernel-cachyos-addons

sudo dnf in kernel-cachyos kernel-cachyos-devel-matched

sudo dnf in cachyos-settings
sudo dracut -f

# It is advised against running ananicy-cpp and a scheduler from the sched-ext framework simultaneously. Use one but not the other.
sudo dnf in ananicy-cpp cachyos-ananicy-rules 
sudo dnf in cachyos-ksm-settings
