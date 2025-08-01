sudo pacman -Sy

sudo pacman -S --noconfirm cosmic-session-git \
  cosmic-edit-git \
  cosmic-player \
  cosmic-store \
  cosmic-term-git \
  cosmic-wallpapers-git \
  cosmic-files-git

sudo systemctl enable --now cosmic-greeter
