#!/bin/sh

# sh /home/pi/bin/connect_bluetooth_devices.sh \"$(< /home/pi/.kodi/userdata/addon_data/script.bluetooth-devices-connector/devices)\""

id=$(shuf -i 0-100 -n1)

poll_bt_ctrl_state() {
  while true;
  do
    echo "(${id}) switching on agent/power/pairable/discoverable states..."

    bluetoothctl power on

    bluetoothctl agent on

    bluetoothctl pairable on

    bluetoothctl discoverable on

    sleep 60
  done
}

poll_bt_service() {
  while true;
  do
    if ! systemctl is-active --quiet bluetooth;
    then
      echo "(${id}) bluetooth service is down, activating..."

      sudo systemctl restart bluetooth
    fi

    sleep 60
  done
}

poll_connection() {
  echo "(${id}) devices: ${1}"

  while true;
  do
    for mac in $1;
    do
      info_output=$(bluetoothctl info $mac)

      is_unreachable=$(echo $info_output | grep -c "Device ${mac} not available")

      if [ $is_unreachable = "1" ];
      then
          echo "(${id}) ${mac} is unreachable, skipping..."

          continue
      fi

      echo "(${id}) Connecting to ${mac}..."

      connection_output=$(bluetoothctl connect $mac)

      has_connection_errors=$(echo $connection_output | grep -c "Failed to connect")

      info_output=$(bluetoothctl info $mac)

      is_connected=$(echo $info_output | grep -c "Connected: yes")

      if [ $is_connected = "1" ] && [ $has_connection_errors = "1" ];
      then
        echo "(${id}) Connected to ${mac}, but with errors (${connection_output})..."
      fi

      is_trusted=$(echo $info_output | grep -c "Trusted: yes")

      if [ $is_connected = "1" ] && [ $is_trusted != "1" ];
      then
        echo "(${id}) Connected to ${mac}, but not trusted, trusting..."

        bluetoothctl trust $mac
      fi

      is_paired=$(echo $info_output | grep -c "Paired: yes")

      if [ $is_connected = "1" ] && [ $is_paired != "1" ];
      then
        echo "(${id}) Connected to ${mac}, but not paired, pairing..."

        bluetoothctl pair $mac
      fi

      if [ $is_connected = "1" ];
      then
        echo "(${id}) Successfully connected to ${mac} device..."
      else
        echo "(${id}) ${mac} not connected, ${connection_output}"
      fi
    done
  done
}

poll_scanning() {
  while true;
  do
    echo "(${id}) Scanning..."

    bluetoothctl --timeout 60 scan on
  done
}

poll_bt_service &

poll_bt_ctrl_state &

poll_scanning &

poll_connection "$1" &

wait
