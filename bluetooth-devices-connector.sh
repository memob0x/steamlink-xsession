#!/bin/sh
devs_raw=$(grep -Po "(?<=id=\"devs\">)(.*?)(?=<\/)" /home/pi/.kodi/userdata/addon_data/script.bluetooth-devices-connector/settings.xml)

devs=$(echo "$devs_raw"|tr ',' ' ')

for dev in $devs
do
	info=`bluetoothctl info $dev`

	if echo "$info" | grep -q "Connected: no"; then
		bluetoothctl connect $dev
	fi
done
