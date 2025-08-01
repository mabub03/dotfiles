sudo pacman -Sy

sudo pacman -S cosmic-session-git \
  cosmic-edit-git \
  cosmic-player-git \
  cosmic-store-git \
  cosmic-term-git \
  cosmic-wallpapers-git \
  cosmic-files-git

sudo systemctl enable --now cosmic-greeter
