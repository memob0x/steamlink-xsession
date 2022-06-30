#!/bin/sh

poll_bt_service() {
  while true;
  do
    if ! systemctl is-active --quiet bluetooth;
    then
      echo "bluetooth service is down, activating"

      sudo systemctl restart bluetooth
    fi

    sleep 6
  done
}

poll_connection() {
  echo $1

  while true;
  do
    for mac in $1;
    do
      echo "Connecting ${mac}..."

      bluetoothctl connect $mac
    done

    sleep 2
  done
}

poll_scanning() {
  while true;
  do
    echo "Scanning..."

    bluetoothctl scan on

    sleep 10
  done
}

poll_bt_service &

poll_connection "$1" &

poll_scanning &

wait
