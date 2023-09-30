#!/bin/bash
# TODO: see if it automatically grabs firmware-iwlwifi for you and if it doesn't then add it
sudo apt install -y network-manager
# NOTICE: don't start now due to needing plasma setup first anyway but maybe add --now if needed
sudo systemctl enable NetworkManager
# debian wiki said to reinsert module to access installed firmware so if wifi doesn't work try this first
# modprobe -r iwlwifi ; modprobe iwlwifi
