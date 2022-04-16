#!/bin/sh

# TODO: check, env should probably be dynamic, also... is this still necessary?
export XDG_RUNTIME_DIR=/run/user/1000

sudo -E -u pi /usr/bin/steamlink
