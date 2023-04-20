wget -c https://steamdeck-packages.steamos.cloud/archlinux-mirror/jupiter-main/os/x86_64/steamdeck-kde-presets-0.17-1-any.pkg.tar.zst
mkdir steamdeck-kde && tar --use-compress-program=unzstd -xvf steamdeck-kde-presets-0.17-1-any.pkg.tar.zst -C steamdeck-kde
sudo cp steamdeck-kde/usr/share/color-schemes/* /usr/share/color-schemes/

sudo cp steamdeck-kde/usr/share/icons/hicolor/scalable/actions/* /usr/share/icons/hicolor/scalable/actions/
sudo cp steamdeck-kde/usr/share/icons/hicolor/scalable/places/* /usr/share/icons/hicolor/scalable/places
# maybe don't need because it is only a install firefox svg
sudo cp steamdeck-kde/usr/share/icons/hicolor/scalable/apps/* /usr/share/icons/hicolor/scalable/apps/


sudo cp steamdeck-kde/usr/share/konsole/* /usr/share/konsole/
sudo cp steamdeck-kde/usr/share/kservices5/ServiceMenus/* /usr/share/kservices5/ServiceMenus/

sudo cp -r steamdeck-kde/usr/share/plasma/avatars/* /usr/share/plasma/avatars/

sudo cp -r steamdeck-kde/usr/share/plasma/desktoptheme/* /usr/share/plasma/desktoptheme/
sudo cp -r steamdeck-kde/usr/share/plasma/kickeractions /usr/share/plasma/
sudo cp -r steamdeck-kde/usr/share/plasma/look-and-feel/* /usr/share/plasma/look-and-feel/

sudo cp -r steamdeck-kde/usr/share/themes/* /usr/share/themes/

sudo cp -r steamdeck-kde/usr/share/wallpapers/* /usr/share/wallpapers/

#maybe???
# 99-pointer.conf
#Section "InputClass"
#	Identifier "Pointer"
#	Driver "libinput"
#	MatchIsPointer "yes"
#	Option "AccelProfile" "flat"
#	Option "AccelSpeed" "0"
#EndSection
sudo cp -r steamdeck-kde/usr/share/X11/xorg.conf.d/* /usr/share/X11/xorg.conf.d/

rm steamdeck-kde-presets-0.17-1-any.pkg.tar.zst
rm -r steamdeck-kde
