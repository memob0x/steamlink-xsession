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
LIST_ADDONS=$(get_ls $cwd/addons)
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

suffix="rkmc-autologin"
suffix_start="$suffix-start"
suffix_end="$suffix-end"

autologin_clean ()
{
	# removes extra ending new line (probably left by perl)
        # otherwise new lines would increase indefinitely with the use of this script
        sudo sh -c "sed -zi 's/\n$//' $FILE_LIGHTDM >> $FILE_LIGHTDM"
}

autologin_uninstall ()
{
	sudo sh -c "perl -0777 -pi -e 's/#$suffix_start.*#$suffix_end//gs' $FILE_LIGHTDM"

	autologin_clean
}

autologin_install ()
{
        sudo sh -c "echo '#$suffix_start' >> $FILE_LIGHTDM"
        sudo sh -c "echo 'autologin-user=pi' >> $FILE_LIGHTDM"
	sudo sh -c "echo 'autologin-session=$1' >> $FILE_LIGHTDM"
        sudo sh -c "echo '#$suffix_end' >> $FILE_LIGHTDM"

	autologin_clean
}
