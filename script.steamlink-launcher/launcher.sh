#!/bin/bash

sudo kill -9 $(pgrep "kodi")

steamlink

kodi --standalone > /dev/null 2>&1 &

exit
