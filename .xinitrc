#!/bin/sh
#
# ~/.xinitrc 
#
# Executed by startx

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

#--no-startup-id dunst &
dunst &
flameshot &
feh --bg-scale wallpapers/DoomGuyStab.jpg
picom -b &
exec i3
