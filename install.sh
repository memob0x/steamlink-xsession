#!/bin/sh

DIR_PROJECT=$(readlink -f "$(dirname "$0")")
DIR_KODI_ADDONS=~/.kodi/addons
DIR_SYSTEMD=/etc/systemd/system

for addon in "script.steamlink-launcher" "script.bluetooth-devices-connector"
do
	rm -r $DIR_KODI_ADDONS/$addon

	cp -r $DIR_PROJECT/$addon $DIR_KODI_ADDONS
done

for service in "steamlink.service"
do
	sudo rm $DIR_SYSTEMD/$service

	sudo cp $DIR_PROJECT/$service $DIR_SYSTEMD

	sudo chmod 664 $DIR_SYSTEMD/$service
done

sudo systemctl daemon-reload
