#!/bin/bash
# download and extract ibm fonts
cd $HOME/Downloads
wget https://github.com/IBM/plex/archive/refs/tags/v6.4.1.zip
unzip v6.4.1.zip

# make a folder for each ibm plex font variant
mkdir -p $HOME/.local/share/fonts
mkdir $HOME/.local/share/fonts/IBM-Plex-Mono
mkdir $HOME/.local/share/fonts/IBM-Plex-Sans
mkdir $HOME/.local/share/fonts/IBM-Plex-Sans-Arabic
mkdir $HOME/.local/share/fonts/IBM-Plex-Sans-Condensed
mkdir $HOME/.local/share/fonts/IBM-Plex-Sans-Devanagari
mkdir $HOME/.local/share/fonts/IBM-Plex-Sans-Hebrew
mkdir $HOME/.local/share/fonts/IBM-Plex-Sans-JP
mkdir $HOME/.local/share/fonts/IBM-Plex-Sans-KR
mkdir $HOME/.local/share/fonts/IBM-Plex-Sans-TC
mkdir $HOME/.local/share/fonts/IBM-Plex-Sans-Thai
mkdir $HOME/.local/share/fonts/IBM-Plex-Sans-Thai-Looped
mkdir $HOME/.local/share/fonts/IBM-Plex-Sans-Variable
mkdir $HOME/.local/share/fonts/IBM-Plex-Serif
mkdir $HOME/.local/share/fonts/IBM-Plex-Math


#copy the extracted otf of each font variant to $HOME/.local/share/fonts
cp $HOME/Downloads/plex-6.4.1/IBM-Plex-Mono/fonts/complete/otf/* $HOME/.local/share/fonts/IBM-Plex-Mono
cp $HOME/Downloads/plex-6.4.1/IBM-Plex-Sans/fonts/complete/otf/* $HOME/.local/share/fonts/IBM-Plex-Sans
cp $HOME/Downloads/plex-6.4.1/IBM-Plex-Sans-Arabic/fonts/complete/otf/* $HOME/.local/share/fonts/IBM-Plex-Sans-Arabic
cp $HOME/Downloads/plex-6.4.1/IBM-Plex-Sans-Condensed/fonts/complete/otf/* $HOME/.local/share/fonts/IBM-Plex-Sans-Condensed
cp $HOME/Downloads/plex-6.4.1/IBM-Plex-Sans-Devanagari/fonts/complete/otf/* $HOME/.local/share/fonts/IBM-Plex-Sans-Devanagari
cp $HOME/Downloads/plex-6.4.1/IBM-Plex-Sans-Hebrew/fonts/complete/otf/* $HOME/.local/share/fonts/IBM-Plex-Sans-Hebrew
# recursive since contains hinted and non hinted variants
cp -r $HOME/Downloads/plex-6.4.1/IBM-Plex-Sans-JP/fonts/complete/otf/* $HOME/.local/share/fonts/IBM-Plex-Sans-JP
cp $HOME/Downloads/plex-6.4.1/IBM-Plex-Sans-KR/fonts/complete/otf/* $HOME/.local/share/fonts/IBM-Plex-Sans-KR
cp $HOME/Downloads/plex-6.4.1/IBM-Plex-Sans-Thai/fonts/complete/otf/* $HOME/.local/share/fonts/IBM-Plex-Sans-Thai
cp $HOME/Downloads/plex-6.4.1/IBM-Plex-Sans-Thai-Looped/fonts/complete/otf/* $HOME/.local/share/fonts/IBM-Plex-Sans-Thai-Looped
# sans variable variant doesn't have an otf version
cp $HOME/Downloads/plex-6.4.1/IBM-Plex-Sans-Variable/fonts/complete/ttf/* $HOME/.local/share/fonts/IBM-Plex-Sans-Variable
cp $HOME/Downloads/plex-6.4.1/IBM-Plex-Serif/fonts/complete/otf/* $HOME/.local/share/fonts/IBM-Plex-Serif

# until next font version that adds in chinese and math fonts gotta get them from master
# TODO: remove this block and add the math, tc, and future sc fonts from latest release instead like done above
cd $HOME/Downloads
git clone https://github.com/IBM/plex.git
cp -r plex/packages/plex-sans-tc/fonts/complete/otf/* $HOME/.local/share/fonts/IBM-Plex-Sans-TC
cp plex/packages/plex-math/fonts/complete/otf/* $HOME/.local/share/fonts/IBM-Plex-Math
rm -rf $HOME/Downloads/plex


# reset the font cache
fc-cache -fv

# remove the no longer needed downloaded and extracted font folders
rm -rf $HOME/Downloads/v6.4.1.zip
rm -rf $HOME/Downloads/plex-6.4.1

# set the default font to IBM Plex Sans and Mono in gnome
#gsettings set org.gnome.desktop.interface font-name 'IBM Plex Sans 11'
#gsettings set org.gnome.desktop.interface monospace-font-name 'IBM Plex Mono 11'
#gsettings set org.gnome.desktop.interface document-font-name 'IBM Plex Sans 11'
