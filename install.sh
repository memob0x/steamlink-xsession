#!/bin/sh

# variables
DIR_PROJECT=$(readlink -f "$(dirname "$0")")
DIR_KODI_ADDONS=/home/pi/.kodi/addons
DIR_SYSTEMD=/etc/systemd/system
DIR_XSESSIONS=/usr/share/xsessions
FILE_LIGHTDM=/etc/lightdm/lightdm.conf
DIR_BIN=/home/pi/bin

# bin files installation
if [ ! -d $DIR_BIN ]; then
  mkdir $DIR_BIN
fi

for bin in "kodi-autologin.conf" "kiosk-browser-autologin.conf" "set-lightdm-autologin.sh" "kiosk-browser-launcher.sh"
do
	rm -r $DIR_BIN/$bin
        cp -r $DIR_PROJECT/$bin $DIR_BIN
done

# kodi addons installation
for addon in "script.steamlink-launcher" "script.bluetooth-devices-connector" "script.kiosk-browser-launcher"
do
	rm -r $DIR_KODI_ADDONS/$addon
	cp -r $DIR_PROJECT/$addon $DIR_KODI_ADDONS
done

# systemd services installation
for service in "steamlink.service"
do
	sudo rm $DIR_SYSTEMD/$service
	sudo cp $DIR_PROJECT/$service $DIR_SYSTEMD
	sudo chmod 664 $DIR_SYSTEMD/$service
done

# xsessions installation
for session in "kiosk-browser.desktop"
do
        sudo rm $DIR_XSESSIONS/$session
        sudo cp $DIR_PROJECT/$session $DIR_XSESSIONS
done

# systemd reload
sudo systemctl daemon-reload
