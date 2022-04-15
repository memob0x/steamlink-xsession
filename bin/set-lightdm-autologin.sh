#!/bin/sh

cwd=$(readlink -f "$(dirname "$0")")

. $cwd/lightdm-autologin.sh

autologin_install $1
