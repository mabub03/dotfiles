#!/bin/bash
# REQUIREMENTS:
# RUN AS SUDO
# npm/node, ghcup (preferably in path from the installation, pip (python package installer), perl
# not included = c++, go, groovy, lua

# Requirements
# Debian/Ubuntu
# apt install python3
# apt install python3-pip
# pip3 install cmake-language-server
# Arch
pacman -S python
pacman -S python-pip
pacman -S nodejs
pacman -S npm
pacman -S ninja
#pacman -S ccls
pip install cmake-language-server

npm i -g bash-language-server
npm install -g vscode-langservers-extracted
npm i -g sql-language-server
npm i -g pyright
npm install -g typescript typescript-language-server
npm install -g vim-language-server
npm install -g intelephense

# Lua Install
cd $HOME/.local/share/nvim
git clone https://github.com/sumneko/lua-language-server
cd lua-language-server
git submodule update --init --recursive
cd 3rd/luamake
compile/install.sh
ninja -f ninja/linux.ninja
cd ../..
./3rd/luamake/luamake rebuild


# ghcup command doesn't work but the installer lets you select if you 
#want to install the haskell langauge server from the install menu
# curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
# stack ghcup install hls
