#!/bin/sh

directory_path_kodi_addons=/home/pi/.kodi/addons
directory_path_systemd=/etc/systemd/system
directory_path_xsessions=/usr/share/xsessions
directory_path_scripts=/home/pi/bin

directory_path_this_script=$(readlink -f "$(dirname "$0")")

script_argument_primary="$1"

list_addons=$(ls -1 $directory_path_this_script/addons)
list_systemd=$(ls -1 $directory_path_this_script/systemd)
list_scripts=$(ls -1 $directory_path_this_script/bin)
list_xsessions=$(ls -1 $directory_path_this_script/xsessions)

uninstall ()
{
  /bin/sh $directory_path_scripts/autologin.sh uninstall

  for bin in $list_scripts
  do
    rm $directory_path_scripts/$bin
  done

  for addon in $list_addons
  do
    sudo rm -rf $directory_path_kodi_addons/$addon
  done

  for session in $list_xsessions
  do
    sudo rm $directory_path_xsessions/$session
  done

  for service in $list_systemd
  do
    sudo rm $directory_path_systemd/$service

    sudo systemctl stop $service

    is_timer=$(echo $list_systemd | grep -z ".timer")

    if [ "$is_timer" ];
    then
      sudo systemctl disable $service
    fi
  done

  sudo systemctl daemon-reload
}

install ()
{
  if [ ! -d "$directory_path_scripts" ];
  then
    mkdir $directory_path_scripts
  fi

  for bin in $list_scripts
  do
    cp $directory_path_this_script/bin/$bin $directory_path_scripts
  done

  /bin/sh $directory_path_scripts/autologin.sh install steamlink

  for addon in $list_addons
  do
    cp -r $directory_path_this_script/addons/$addon $directory_path_kodi_addons
  done

  for session in $list_xsessions
  do
    sudo cp $directory_path_this_script/xsessions/$session $directory_path_xsessions
  done

  sudo -E systemctl import-environment BLUETOOTH_DEVICES_CONNECTOR_DEBUG

  for service in $list_systemd
  do
    sudo cp $directory_path_this_script/systemd/$service $directory_path_systemd
    sudo chmod 664 $directory_path_systemd/$service

    sudo systemctl start $service

    is_timer=$(echo $list_systemd | grep -z ".timer")

    if [ "$is_timer" ];
    then
      sudo systemctl enable $service
    fi
  done

  sudo systemctl daemon-reload

  # possibly install missing bluetooth 5 firmware
  # NOTE: binaries from 20201202_mpow_BH456A_driver+for+Linux.7z
  for firmware_binary_name in "rtl8761bu_fw" "rtl8761bu_config";
  do
    binary_path_bluetooth_main_firmware="/usr/lib/firmware/rtl_bt/$firmware_binary_name.bin"

    if [ ! -f "$binary_path_bluetooth_main_firmware" ];
    then
      sudo cp "$directory_path_this_script/firmware/$firmware_binary_name" "$binary_path_bluetooth_main_firmware"
    fi
  done
}

if [ "$script_argument_primary" = "uninstall" ]
then
  uninstall
fi

if [ "$script_argument_primary" = "install" ]
then
  uninstall

  install
fi
