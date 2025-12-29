#!/bin/bash
sudo cp $HOME/dotfiles/cosmic_utilities/cosmic_cursor_setup/default_files/environment /etc/
sudo cp $HOME/dotfiles/cosmic_utilities/cosmic_cursor_setup/default_files/index.theme /usr/share/icons/default

unlink /home/toasty/.local/share/icons/default

