#!/bin/sh

# thanks https://github.com/aiguofer/dotfiles/blob/master/system/usr/local/bin/a2dp-fix

expected_profile=$1

if [ ! "$expected_profile" ];
then
    expected_profile="a2dp_sink" # headset_head_unit | a2dp_sink | off
fi

bt_device_addr=$(pacmd list-cards | grep -i 'name:.*bluez_card' | sed -E 's/.*<?bluez_card\.([A-Z0-9_]+)>?/\1/')

if [ ! "$bt_device_addr" ];
then
    echo "Failed, no device available."

    exit
fi

device_mac=$(echo $bt_device_addr | sed 's/_/:/g')

echo "Attempting to connect audio to ${device_mac} ${expected_profile}..."

profile_status=$(pacmd list-cards | grep -A30 bluez | grep $expected_profile | sed -E 's/.* available: ([a-z]+)\)/\1/g')

if [ "$profile_status" = "no" ];
then
    echo "Failed, ${expected_profile} profile not available (Status: ${profile_status})."

    exit
fi

pactl set-card-profile bluez_card.$bt_device_addr $expected_profile

bluez_active_profile=$(pacmd list-cards | grep -A30 bluez | grep "active profile" | sed -E 's/.*<([a-z_-]+)>.*/\1/g')

if [ "$bluez_active_profile" = "$expected_profile" ];
then
    echo "Profile ${expected_profile} successfully set"

    pacmd set-default-sink bluez_sink.$bt_device_addr.$expected_profile

    sleep 2

    aplay /usr/share/kodi/addons/resource.uisounds.kodi/resources/notify.wav

    echo "Done."

    exit
fi

echo "Sink set failed, current sink is \"${bluez_active_profile}\" while the expected was \"${expected_profile}\""
