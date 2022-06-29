#!/bin/sh

uid=$(id -u pi)

runtime_dir=/run/user/$uid

export XDG_RUNTIME_DIR=$runtime_dir

sudo -u pi -E /usr/bin/steamlink
