#!/bin/sh

cwd=$(readlink -f "$(dirname "$0")")

DIR_KODI_ADDONS=/home/pi/.kodi/addons
DIR_SYSTEMD=/etc/systemd/system
DIR_XSESSIONS=/usr/share/xsessions
FILE_LIGHTDM=/etc/lightdm/lightdm.conf
DIR_BIN=/home/pi/bin
DIR_CONF=/home/pi/.config

get_ls ()
{
	echo $(ls -1 $1)
}

LIST_SCRIPTS=$(get_ls $cwd/bin)
LIST_CONFIGS=$(get_ls $cwd/config)
LIST_ADDONS=$(get_ls $cwd/addons)
LIST_XSESSIONS=$(get_ls $cwd/xsessions)
LIST_SYSTEMDS=$(get_ls $cwd/systemd)

systemds_activate ()
{
	sudo systemctl enable bluetooth-devices-connector.timer
	sudo systemctl start bluetooth-devices-connector.timer
}

systemds_deactivate ()
{
        sudo systemctl stop bluetooth-devices-connector.timer
        sudo systemctl disable bluetooth-devices-connector.timer
}

systemds_reload ()
{
	sudo systemctl daemon-reload
}
