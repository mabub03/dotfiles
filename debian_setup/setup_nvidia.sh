 #!/bin/bash
sudo apt-add-repository --component contrib non-free
sudo apt update
# NOTICE: if debian 12 doesn't pull in all firmware package like sources say it should then add: firmware-misc-nonfree
sudo apt install -y nvidia-driver
