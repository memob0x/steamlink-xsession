#!/bin/bash

sh install.sh

sudo kill -9 $(pgrep "kodi")

kodi --standalone > /dev/null 2>&1 &

exit

