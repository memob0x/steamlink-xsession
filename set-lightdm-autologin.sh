#!/bin/sh

FILE_LIGHTDM=/etc/lightdm/lightdm.conf
opts="kodi kiosk-browser"
DIR_BIN=/home/pi/bin/
suffix="autologin"

# cleanup
for seat in $opts
do
        sudo sh -c "perl -0777 -pi -e 's/#$seat-$suffix-start.*#$seat-$suffix-end//gs' $FILE_LIGHTDM"
done

# install
if [ ! -d $DIR_BIN ]; then
  mkdir $DIR_BIN
fi

if echo $opts | grep -w $1 > /dev/null; then
	sudo sh -c "echo '#$1-$suffix-start' >> $FILE_LIGHTDM"
	sudo sh -c "cat $DIR_BIN/$1-$suffix.conf >> $FILE_LIGHTDM"
	sudo sh -c "echo '#$1-$suffix-end' >> $FILE_LIGHTDM"
fi
