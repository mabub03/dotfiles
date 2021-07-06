#!/bin/bash
# REQUIREMENTS:
# RUN AS SUDO
# npm/node, ghcup (preferably in path from the installation, pip (python package installer), perl
# not included = c++, go, groovy, lua

# Requirements
# Debian/Ubuntu
sudo apt remove rustc cargo
sudo apt install python3 python3-pip nodejs npm ninja-build

# Install Rust
cd $HOME
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env

# Install Rust Analyzer Stable Release
cd $HOME
git clone https://github.com/rust-analyzer/rust-analyzer.git && cd rust-analyzer
cargo xtask install --server

#pip3 install cmake-language-server
# Arch
#pacman -S python
#pacman -S python-pip
#pacman -S nodejs
#pacman -S npm
#pacman -S ninja
#pacman -S ccls
#pip install cmake-language-server

sudo npm i -g bash-language-server
sudo npm install -g vscode-langservers-extracted
sudo npm i -g sql-language-server
sudo npm i -g pyright
sudo npm install -g typescript typescript-language-server
sudo npm install -g vim-language-server
sudo npm install -g intelephense

# Lua Install
cd $HOME/.local/share/nvim
git clone https://github.com/sumneko/lua-language-server
cd lua-language-server
git submodule update --init --recursive
cd 3rd/luamake
compile/install.sh
cd ../..
./3rd/luamake/luamake rebuild


# ghcup command doesn't work but the installer lets you select if you 
#want to install the haskell langauge server from the install menu
# curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
# stack ghcup install hls
