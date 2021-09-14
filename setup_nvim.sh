#!/bin/bash
#git clone --depth=1 https://github.com/savq/paq-nvim.git \
#    "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/start/paq-nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

cp -r $HOME/dotfiles/.config/nvim $HOME/.config
