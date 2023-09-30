#!/bin/bash
sudo apt install -y curl 7zip
sudo apt install fontforge python3-fontforge

cd $HOME/.local/share/fonts
curl -O https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg
7z x SF-Pro.dmg
cd SFProFonts
7z x 'SF Pro Fonts.pkg'
7z x 'Payload~'
mv Library/Fonts/* $HOME/.local/share/fonts
cd ..

curl -O https://devimages-cdn.apple.com/design/resources/download/NY.dmg
7z x NY.dmg
cd NYFonts
7z x 'NY Fonts.pkg'
7z x 'Payload~'
mv Library/Fonts/* $pkgdir/fontfiles
cd ..

rm -r *.dmg NYFonts SFProFonts

curl -O https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg
7z x SF-Mono.dmg
cd SFMonoFonts
7z x 'SF Mono Fonts.pkg'
7z x 'Payload~'

mkdir $HOME/FontPatcher
cd $HOME/FontPatcher
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FontPatcher.zip
unzip FontPatcher.zip
# add a -s for mono glyphs
fontforge -script font-patcher -c $HOME/.local/share/fonts/SFMonoFonts/Library/Fonts/SF-Mono-Bold.otf
fontforge -script font-patcher -c $HOME/.local/share/fonts/SFMonoFonts/Library/Fonts/SF-Mono-BoldItalic.otf
fontforge -script font-patcher -c $HOME/.local/share/fonts/SFMonoFonts/Library/Fonts/SF-Mono-Heavy.otf
fontforge -script font-patcher -c $HOME/.local/share/fonts/SFMonoFonts/Library/Fonts/SF-Mono-HeavyItalic.otf
fontforge -script font-patcher -c $HOME/.local/share/fonts/SFMonoFonts/Library/Fonts/SF-Mono-Light.otf
fontforge -script font-patcher -c $HOME/.local/share/fonts/SFMonoFonts/Library/Fonts/SF-Mono-LightItalic.otf
fontforge -script font-patcher -c $HOME/.local/share/fonts/SFMonoFonts/Library/Fonts/SF-Mono-Medium.otf
fontforge -script font-patcher -c $HOME/.local/share/fonts/SFMonoFonts/Library/Fonts/SF-Mono-MediumItalic.otf
fontforge -script font-patcher -c $HOME/.local/share/fonts/SFMonoFonts/Library/Fonts/SF-Mono-Regular.otf
fontforge -script font-patcher -c $HOME/.local/share/fonts/SFMonoFonts/Library/Fonts/SF-Mono-RegularItalic.otf
fontforge -script font-patcher -c $HOME/.local/share/fonts/SFMonoFonts/Library/Fonts/SF-Mono-Semibold.otf
fontforge -script font-patcher -c $HOME/.local/share/fonts/SFMonoFonts/Library/Fonts/SF-Mono-SemiboldItalic.otf

cp SFMonoNerdFont-* $HOME/.local/share/fonts

rm -rf $HOME/.local/share/fonts/SFMonoFonts
rm -rf $HOME/FontPatcher
