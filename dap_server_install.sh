#!/bin/bash
# install python debugpy debugger
pip install debugpy

mkdir $HOME/dev/debugger
cd $HOME/dev/debugger

# install javascript/chrome vscode-chrome-debug debugger
git clone https://github.com/Microsoft/vscode-chrome-debug
cd ./vscode-chrome-debug
npm install
npm run build
cd ..

# install php vscode-php-debug debugger
git clone https://github.com/xdebug/vscode-php-debug.git
cd vscode-php-debug
npm install && npm run build
cd ..

# install javascript/node node-debug 2 debugger 
# (sadly vscode-js-debug doesn't work with neovim)
npm install -g gulp
git clone https://github.com/microsoft/vscode-node-debug2.git
cd vscode-node-debug2
npm install
gulp build
cd ..

# install dart debugger
npm install -g webpack
git clone https://github.com/Dart-Code/Dart-Code.git
cd Dart-Code
npx webpack --mode production
cd ..

# install .net (C# and F#) samsung netcoredbg debugger
# sudo dnf install clang
#git clone https://github.com/Samsung/netcoredbg.git
#cd netcoredbg
#mkdir build
#cd build
#CC=clang CXX=clang++ cmake ..
#make
#make install
# remove artifacts
#cd ..
#rm -rf build src/debug/netcoredbg/bin bin
