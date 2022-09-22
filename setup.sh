#!/bin/sh

directory_path_services=/etc/systemd/user
directory_path_xsessions=/usr/share/xsessions
directory_path_scripts=/home/$(whoami)/bin

directory_path_this_script=$(readlink -f "$(dirname "$0")")

script_argument_primary="$1"

if [ "$script_argument_primary" = "uninstall" ]
then
  echo "removing script";

  rm $directory_path_scripts/steamlink.sh

  echo "removing x session";

  sudo rm $directory_path_xsessions/steamlink.desktop

  echo "removing service";

  sudo rm $directory_path_services/steamlink.service

  echo "done";

  exit 0
fi

if [ "$script_argument_primary" = "install" ]
then
  mkdir -p $directory_path_scripts
  
  echo "copying script";

  cp $directory_path_this_script/steamlink.sh $directory_path_scripts
  
  echo "copying x session";

  sudo cp $directory_path_this_script/steamlink.desktop $directory_path_xsessions

  echo "copying service";

  sudo cp $directory_path_this_script/steamlink.service $directory_path_services

  echo "done";

  exit 0
fi

echo "invalid command provided, nothing to do"

exit 1
