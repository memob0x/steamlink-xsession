#!/bin/bash

openvt -c 7 -s -f clear

emustation_launched=false
mediacenter_stopped=false

while true;
do
	mediacenter_state="$(systemctl is-active mediacenter)"
	emustation_state="$(pgrep -f /usr/bin/emulationstation)"

	if ( [ "$mediacenter_state" != "active" ] && [ "$emustation_launched" = true ] && [ ! "$emustation_state" ] )
	then
		echo "resuming mediacenter"

		sudo systemctl start mediacenter &

		exit
	fi

	if ( [ "$mediacenter_state" != "active" ] && [ "$emustation_launched" = false ] )
	then
		echo "launching emulation station"

		emustation_launched=true

		/usr/bin/emulationstation &
	fi

	if ( [ "$mediacenter_state" = "active" ] && [ "$mediacenter_stopped" = false ] )
        then
                echo "stopping mediacenter"

		mediacenter_stopped=true

                sudo systemctl stop mediacenter &
        fi
done
