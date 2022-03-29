#!/bin/bash

systemctl stop mediacenter

if [ "$(systemctl is-active hyperion.service)" = "active" ]; then
	systemctl restart hyperion;
fi

sudo -u osmc emulationstation

openvt -c 7 -s -f clear

systemctl start mediacenter
