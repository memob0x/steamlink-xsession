#!/bin/sh

uid=$(id -u pi)

runtime_dir=/run/user/$uid

sudo service lightdm stop

while [ ! -d $runtime_dir/pulse ]; do sleep 1; done

sh /home/pi/bin/autologin.sh install steamlink
