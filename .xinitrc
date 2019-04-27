#!/bin/bash

#load .xprofile
[ -f ~/.xprofile ] && source ~/.xprofile
dbus-launch fcitx

#xsetroot for dwm bar
while true
do
	VOL="VOL:$(amixer get Headphone | tail -1 | sed 's/.*\[\([0-9]*%\)\].*/\1/')"
	LOCALTIME=$(date +%Y-%m-%d\ %H:%M)
	IP=$(for i in `ip r`; do echo $i; done | grep -A 1 src | tail -n1) # can get confused if you use vmware

	if acpi -a | grep off-line > /dev/null
	then
		BAT="BAT:$(acpi -b | awk '{ print $4 }' | tr -d ',')"
		xsetroot -name "$IP $BAT $VOL $LOCALTIME"
	else
		xsetroot -name "$IP $VOL $LOCALTIME"
	fi
	sleep 20s
done &

#set wallpaper with feh
feh --bg-scale ~/images/wall.jpg

#enable fn key bind
xbindkeys

#enable compton
compton -b --config ~/.config/compton/compton.conf

#launch dwm
exec dwm;
#no scripts work below here.
