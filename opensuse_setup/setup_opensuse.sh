#!/bin/bash

sudo zypper in nvidia-video-G06 nvidia-utils-G06
# for package locks if zypper al doesn't work look at this thread:
# https://www.reddit.com/r/openSUSE/comments/10rnrnu/comment/j6xnukt

# if no wifi by default then check this:
# https://forums.opensuse.org/t/getting-wi-fi-working-during-after-installation/145297/9

# move .config items
cp -r $HOME/dotfiles/.config/btop $HOME/.config/btop
cp $HOME/dotfiles/.config/starship.toml $HOME/.config

# setup zsh
cp $HOME/dotfiles/opensuse_setup/.zshrc $HOME/.zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions

# disabe wifi powersave
sudo bash -c 'cat > /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf' <<-'EOF'
[connection]
wifi.powersave=2
EOF

sudo systemctl restart NetworkManager
echo "Setup script has finished running"
