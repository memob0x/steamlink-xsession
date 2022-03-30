#!/bin/bash

sudo kill -9 $(pgrep "kodi")

emulationstation

kodi --standalone > /dev/null 2>&1 &

exit
