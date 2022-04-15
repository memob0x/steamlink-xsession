#!/bin/sh

xset s noblank
xset s off
xset -dpms

# https://forums.raspberrypi.com/viewtopic.php?p=1988646
echo 'export CHROMIUM_FLAGS="$CHROMIUM_FLAGS --use-gl=egl"' > /etc/chromium.d/egl

/usr/bin/chromium-browser --window-size=1920,1080 --window-position=0,0

sh /home/pi/bin/set-lightdm-autologin.sh kodi

sudo service lightdm restart
