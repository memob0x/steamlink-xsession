#!/bin/sh

DIR=$(readlink -f "$(dirname "$0")")

# kodi addon installation
# --------------------------------------------------------------

rm -rf ~/.kodi/addons/script.steamlink-launcher

cp -r $DIR/script.steamlink-launcher ~/.kodi/addons/

# steamlink systemd service installation
# --------------------------------------------------------------

sudo rm /etc/systemd/system/steamlink.service

sudo cp $DIR/steamlink.service /etc/systemd/system/

sudo chmod 664 /etc/systemd/system/steamlink.service

sudo systemctl daemon-reload

# bluetooth devices connector addon installation
# --------------------------------------------------------------

rm -rf ~/.kodi/addons/script.bluetooth-devices-connector

cp -r $DIR/script.bluetooth-devices-connector ~/.kodi/addons/
