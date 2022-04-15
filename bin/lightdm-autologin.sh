#!/bin/sh

FILE_LIGHTDM=/etc/lightdm/lightdm.conf
opts="kodi kiosk-browser"
suffix="autologin"
suffix_start="$suffix-start"
suffix_end="$suffix-end"

autologin_uninstall ()
{
	for seat in $opts
	do
		sudo sh -c "perl -0777 -pi -e 's/#$seat-$suffix_start.*#$seat-$suffix_end//gs' $FILE_LIGHTDM"
	done
}

autologin_install ()
{
	if echo $opts | grep -w $1 > /dev/null; then
		sudo sh -c "echo '#$1-$suffix_start' >> $FILE_LIGHTDM"
		sudo sh -c "cat /home/pi/.config/$1-$suffix.conf >> $FILE_LIGHTDM"
		sudo sh -c "echo '#$1-$suffix_end' >> $FILE_LIGHTDM"
	fi

	# removes extra ending new line (probably left by perl)
	# otherwise new lines would increase indefinitely with the use of this script
	sudo sh -c "sed -zi 's/\n$//' $FILE_LIGHTDM >> $FILE_LIGHTDM"
}
