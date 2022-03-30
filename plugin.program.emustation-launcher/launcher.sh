#!/bin/bash

sudo systemctl stop mediacenter &

sleep 10

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/sbin:/usr/sbin:/usr/osmc/bin:/opt/vc/bin

/opt/retropie/supplementary/emulationstation/emulationstation

sudo systemctl start mediacenter

exit
