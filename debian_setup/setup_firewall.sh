#!/bin/bash
# TODO: see if you should use apparmor or se linux for debian
#rsyslog is an suggested package but don't think I need it since journald is a thing
sudo apt install ufw plasma-firewall
sudo ufw enable

sudo ufw default deny incoming
sudo ufw default allow outgoing

sudo ufw allow ssh
sudo ufw allow samba
sudo ufw allow 1714:1764/tcp
sudo ufw allow 1714:1764/udp

sudo ufw reload
#sudo ufw deny 1025-65535/tcp
#sudo ufw deny 1025-65535/udp
