#!/bin/sh

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

poll_connection "$1" &

poll_scanning &

wait
