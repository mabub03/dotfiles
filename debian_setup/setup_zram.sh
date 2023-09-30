#TODO: script broken since need to add the zram generator and zram-vm-settings files contents properly so FIX IT
# install zram generator package
sudo apt install systemd-zram-generator

# install zram generator
# add to /etc/systemd/zram-generator.conf
[zram0]
zram-size = min(ram, 16384)
compression-algorithm = zstd
swap-priority = 180
fs-type = swap

# change /etc/sysctl.d/10-zram-vm-settings.conf
vm.swappiness = 180
vm.watermark_boost_factor = 0
vm.watermark_scale_factor = 125
vm.dirty_bytes = 268435456
vm.dirty_background_bytes = 134217728

sudo systemctl daemon-reload
sudo systemctl start /dev/zram0
sudo sysctl -p /etc/sysctl.d/10-zram-vm-settings.conf

