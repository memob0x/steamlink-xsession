#!/bin/bash

chmod 755 ./launch-emustation_watchdog.sh

sudo openvt -c 7 -s -f clear

sudo su -c "nohup sudo openvt -c 7 -s -f -l ./launch-emustation_watchdog.sh >/dev/null 2>&1 &"
