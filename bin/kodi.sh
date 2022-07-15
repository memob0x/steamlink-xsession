#!/bin/sh

username=$(whoami)

if [ "${username}" = "root" ];
then
  echo "Can't act as ${username}, aborting."

  exit 1
fi

launch(){
  echo "killing steamlink"

  sh /home/$username/bin/steamlink.sh kill

  echo "setting kodi as autologin session"

  sh /home/$username/bin/autologin.sh install kodi

  sleep 1

  echo "restarting lightdm"

  if [ "$(systemctl is-active lightdm.service)" = "active" ];
  then
    sudo service lightdm restart
  else
    sudo service lightdm start
  fi
}

if [ "${1}" = "launch" ];
then
  launch

  exit 0
fi

echo "Invalid argument supplied."

exit 1
