#!/bin/sh

username=$(whoami)

directory_path_systemd_system=/etc/systemd/system
directory_path_xsessions=/usr/share/xsessions
directory_path_scripts=/home/$username/bin

directory_path_this_script=$(readlink -f "$(dirname "$0")")

script_argument_primary="$1"

if [ "$script_argument_primary" = "uninstall" ]
then
  rm $directory_path_scripts/steamlink.sh

  sudo rm $directory_path_xsessions/steamlink.desktop

  sudo rm $directory_path_systemd_system/steamlink.service

  exit 0
fi

if [ "$script_argument_primary" = "install" ]
then
  mkdir -p $directory_path_scripts

  cp $directory_path_this_script/steamlink.sh $directory_path_scripts

  sudo cp $directory_path_this_script/steamlink.desktop $directory_path_xsessions

  sudo cp $directory_path_this_script/steamlink.service $directory_path_systemd_system

  sudo sed -i "s|__USERNAME__|${username}|g" $directory_path_systemd_system/steamlink.service

  exit 0
fi

echo "invalid command provided"

exit 1
