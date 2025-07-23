sudo dnf in lz4

# add this to /etc/systemd/zram-generator.conf
[zram0]
zram-size = min(ram / 2, 8192)
compression-algorithm = lz4
fs-type = swap

# add this to /etc/sysctl.d/99-vm-zram-settings.conf
vm.swappiness = 180
vm.watermark_boost_factor = 0
vm.watermark_scale_factor = 125
vm.page-cluster = 0

sudo sysctl -p /etc/sysctl.d/99-vm-zram-params.conf
systemctl restart systemd-zram-setup@zram0.service

# adding this to this file for now change vm.max-map-count also
sudo echo "vm.max_map_count=2147483642" >> /etc/sysctl.d/99-vm-max-map-count.conf
sudo sysctl -p /etc/sysctl.d/99-vm-max-map-count.conf

