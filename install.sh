#!/bin/sh

# variables
DIR_PROJECT=$(readlink -f "$(dirname "$0")")
DIR_KODI_ADDONS=~/.kodi/addons
DIR_SYSTEMD=/etc/systemd/system
DIR_XSESSIONS=/usr/share/xsessions

# lightdm kodi autologin seat configuration
sudo sh -c "perl -0777 -pi -e 's/#kodi-autologin-start.*#kodi-autologin-end//gs' /etc/lightdm/lightdm.conf"
sudo sh -c "echo '#kodi-autologin-start' >> /etc/lightdm/lightdm.conf"
sudo sh -c "cat kodi-autologin.conf >> /etc/lightdm/lightdm.conf"
sudo sh -c "echo '#kodi-autologin-end' >> /etc/lightdm/lightdm.conf"

# lightdm kiosk-browser autologin seat configuration
sudo sh -c "perl -0777 -pi -e 's/#kiosk-browser-autologin-start.*#kiosk-browser-autologin-end//gs' /etc/lightdm/lightdm.conf"
sudo sh -c "echo '#kiosk-browser-autologin-start' >> /etc/lightdm/lightdm.conf"
sudo sh -c "cat kiosk-browser-autologin.conf >> /etc/lightdm/lightdm.conf"
sudo sh -c "echo '#kiosk-browser-autologin-end' >> /etc/lightdm/lightdm.conf"

# kodi addons installation
for addon in "script.steamlink-launcher" "script.bluetooth-devices-connector" "script.kiosk-browser-launcher"
do
	rm -r $DIR_KODI_ADDONS/$addon

	cp -r $DIR_PROJECT/$addon $DIR_KODI_ADDONS
done

# systemd services installation
for service in "steamlink.service" "kiosk-browser.service"
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
