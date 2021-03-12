#!/bin/bash
# REQUIREMENTS:
# npm/node, ghcup (preferably in path from the installation, pip (python package installer), perl
# not included = c++, go, groovy, lua

npm i -g bash-language-server
npm install -g vscode-css-languageserver-bin
npm install -g vscode-html-languageserver-bin
npm install -g vscode-json-languageserver
npm i -g sql-language-server
npm i -g pyright
npm install -g typescript typescript-language-server
npm install -g vim-language-server
npm install -g intelephense
apt install python3-pip
pip3 install cmake-language-server

# ghcup command doesn't work but the installer lets you select if you 
#want to install the haskell langauge server from the install menu
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
# stack ghcup install hls
