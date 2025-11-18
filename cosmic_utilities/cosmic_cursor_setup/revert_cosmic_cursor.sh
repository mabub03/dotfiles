#!/bin/bash
sudo cp $HOME/dotfiles/CosmicCursorSetup/DefaultFiles/environment /etc/
sudo cp $HOME/dotfiles/CosmicCursorSetup/DefaultFiles/index.theme /usr/share/icons/

unlink /home/toasty/.local/share/icons/default

