#!/bin/sh

# TODO: should be dynamic
export XDG_RUNTIME_DIR=/run/user/1000

# forcing kodi and lightdm to shutdown before steamlink launch
# TODO: check if sudo service lightdm stop is enough instead
sudo kill -9 $(pgrep kodi) & sudo kill -9 $(pgrep lightdm)

sudo -E -u pi /usr/bin/steamlink
