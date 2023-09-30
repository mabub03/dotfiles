#!/bin/bash

# Set Color
RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"

# For root control
if [ "$(id -u)" != 0 ]; then
  printf "${RED}"
  cat <<EOL
============================================================================
You are not root! This script must be run as root!
============================================================================
EOL
  printf "${ENDCOLOR}"
  exit 1
fi

# alter vm max map value
sudo echo "vm.max_map_count=2147483642" >> /etc/sysctl.conf
sudo sysctl -p
