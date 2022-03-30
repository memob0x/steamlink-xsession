#!/bin/bash

sudo kill -9 $(pgrep "kodi")

sudo systemctl start lightdm

exit
