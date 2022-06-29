#!/bin/sh

sh /home/pi/bin/autologin.sh install kodi

sleep 1

sudo service lightdm start
