#!/bin/sh

directory_path_kodi_addons=/home/pi/.kodi/addons
directory_path_systemd_system=/etc/systemd/system
directory_path_systemd_user=/home/pi/.config/systemd/user
directory_path_xsessions=/usr/share/xsessions
directory_path_scripts=/home/pi/bin

directory_path_this_script=$(readlink -f "$(dirname "$0")")

script_argument_primary="$1"

list_addons=$(ls -1 $directory_path_this_script/addons)
list_systemd_system=$(ls -1 $directory_path_this_script/systemd/system)
list_systemd_user=$(ls -1 $directory_path_this_script/systemd/user)
list_scripts=$(ls -1 $directory_path_this_script/bin)
list_xsessions=$(ls -1 $directory_path_this_script/xsessions)

uninstall_xsessions ()
{
  for session in $list_xsessions
  do
    sudo rm $directory_path_xsessions/$session
  done
}

uninstall_services_system ()
{
  for service in $list_systemd_system
  do
    sudo rm $directory_path_systemd_system/$service

    sudo systemctl stop $service
  done

  sudo systemctl daemon-reload
}

uninstall_services_user ()
{
  for service in $list_systemd_user
  do
    sudo rm $directory_path_systemd_user/$service

    systemctl --user stop $service
  done

  systemctl --user daemon-reload
}

uninstall_scripts ()
{
  for bin in $list_scripts
  do
    rm $directory_path_scripts/$bin
  done
}

uninstall_addons ()
{
  for addon in $list_addons
  do
    sudo rm -rf $directory_path_kodi_addons/$addon
  done
}

uninstall_all ()
{
  /bin/sh $directory_path_scripts/autologin.sh uninstall

  uninstall_xsessions

  uninstall_services_system

  uninstall_services_user

  uninstall_scripts

  uninstall_addons
}

install_bt_drivers ()
{
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

install_services_system ()
{
  sudo -E systemctl import-environment BLUETOOTH_DEVICES_CONNECTOR_DEBUG

  for service in $list_systemd_system
  do
    sudo cp $directory_path_this_script/systemd/system/$service $directory_path_systemd_system
    sudo chmod 664 $directory_path_systemd_system/$service

    sudo systemctl start $service
  done

  sudo systemctl daemon-reload
}

install_services_user ()
{
  sudo -E systemctl import-environment BLUETOOTH_DEVICES_CONNECTOR_DEBUG

  for service in $list_systemd_user
  do
    sudo cp $directory_path_this_script/systemd/user/$service $directory_path_systemd_user
    sudo chmod 664 $directory_path_systemd_user/$service

    systemctl --user start $service
  done

  systemctl --user daemon-reload
}

install_scripts ()
{
  if [ ! -d "$directory_path_scripts" ];
  then
    mkdir $directory_path_scripts
  fi

  for bin in $list_scripts
  do
    cp $directory_path_this_script/bin/$bin $directory_path_scripts
  done
}

install_addons ()
{
  for addon in $list_addons
  do
    cp -r $directory_path_this_script/addons/$addon $directory_path_kodi_addons
  done
}

install_xsessions ()
{
  for session in $list_xsessions
  do
    sudo cp $directory_path_this_script/xsessions/$session $directory_path_xsessions
  done
}

install_all ()
{
  install_scripts

  /bin/sh $directory_path_scripts/autologin.sh install steamlink

  install_addons

  install_xsessions

  install_services_system

  install_services_user

  install_bt_drivers
}

if [ "$script_argument_primary" = "uninstall" ]
then
  uninstall_all
fi

if [ "$script_argument_primary" = "install" ]
then
  uninstall_all

  install_all
fi 
