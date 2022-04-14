#!/bin/sh

# variables
DIR_PROJECT=$(readlink -f "$(dirname "$0")")
DIR_KODI_ADDONS=/home/pi/.kodi/addons
DIR_SYSTEMD=/etc/systemd/system
DIR_XSESSIONS=/usr/share/xsessions
FILE_LIGHTDM=/etc/lightdm/lightdm.conf
DIR_BIN=/home/pi/bin
DIR_CONF=/home/pi/.config

# bin files installation
if [ ! -d $DIR_BIN ]; then
	mkdir $DIR_BIN
fi

for bin in "set-lightdm-autologin.sh" "kiosk-browser-launcher.sh"
do
	rm -r $DIR_BIN/$bin
        cp -r $DIR_PROJECT/bin/$bin $DIR_BIN
done

for conf in "kodi-autologin.conf" "kiosk-browser-autologin.conf"
do
        rm -r $DIR_CONF/$conf
        cp -r $DIR_PROJECT/config/$conf $DIR_CONF
done

# kodi addons installation
for addon in "script.steamlink-launcher" "script.bluetooth-devices-connector" "script.kiosk-browser-launcher"
do
	rm -r $DIR_KODI_ADDONS/$addon
	cp -r $DIR_PROJECT/$addon $DIR_KODI_ADDONS
done

# xsessions installation
for session in "kiosk-browser.desktop"
do
        sudo rm $DIR_XSESSIONS/$session
        sudo cp $DIR_PROJECT/xsessions/$session $DIR_XSESSIONS
done

# systemd halting
sudo systemctl stop bluetooth-devices-connector.timer
sudo systemctl disable bluetooth-devices-connector.timer

# systemd services installation
for service in "steamlink.service" "bluetooth-devices-connector.service" "bluetooth-devices-connector.timer"
do
        sudo rm $DIR_SYSTEMD/$service
        sudo cp $DIR_PROJECT/systemd/$service $DIR_SYSTEMD
        sudo chmod 664 $DIR_SYSTEMD/$service
done

# systemd resuming
sudo systemctl enable bluetooth-devices-connector.timer
sudo systemctl start bluetooth-devices-connector.timer

# systemd reload
sudo systemctl daemon-reload
