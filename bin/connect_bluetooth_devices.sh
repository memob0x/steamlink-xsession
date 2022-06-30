#!/bin/sh

while true;
do
  for mac in $1
  do
    echo "Scanning..."

    bluetoothctl scan on

    sleep 4

    bluetoothctl scan off

    echo "Connecting ${mac}..."

    bluetoothctl connect $mac

    sleep 0.5
  done
done
