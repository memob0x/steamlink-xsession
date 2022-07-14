#!/bin/sh

username=$(whoami)

if [ "${username}" = "root" ];
then
  echo "Can't act as ${username}, aborting."

  exit 1
fi

launch(){
  echo "acting as ${username}"

  userid=$(id -u $username)

  runtimedir=/run/user/$userid


  if [ "$(systemctl is-active lightdm.service)" = "active" ];
  then
    echo "stopping lightdm"

    sudo service lightdm stop
  fi


  echo "waiting..."

  sleep 6 # TODO: check y this is needed in order to avoid steamlink running with error "Failed to move cursor on screen HDMI1: -13"


  echo "setting steamlink as autologin session"

  sh /home/$username/bin/autologin.sh install steamlink


  echo "waiting for runtime directory"

  while [ ! -d $runtimedir/pulse ];
  do
    sleep 1;
  done


  export XDG_RUNTIME_DIR=$runtimedir

  echo "runtime folder is ${XDG_RUNTIME_DIR}"


  echo "launching steamlink"

  sudo -u $username -E /usr/bin/steamlink

  echo "\n"

  sleep 1


  echo "Steamlink exited"
}

if [ "${1}" = "launch" ];
then
  launch

  exit 0
fi

echo "Invalid argument supplied."

exit 1
