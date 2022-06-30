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

list_systemd_autostart="bluetooth-devices-connector.service"

uninstall_xsessions ()
{
  echo "uninstalling xsessions"

  for session in $list_xsessions
  do
    echo "uninstalling ${session} xsession"

    sudo rm $directory_path_xsessions/$session
  done
}

uninstall_services_system ()
{
  echo "uninstalling system services"

  for service in $list_systemd_system
  do
    if echo $list_systemd_autostart | grep -q $service;
    then
      echo "disabling system service ${service} autostart"

      sudo systemctl disable $service
    fi

    echo "uninstalling system service ${service}"

    sudo rm $directory_path_systemd_system/$service
  done

  echo "reloading system services"

  sudo systemctl daemon-reload
}

uninstall_services_user ()
{
  echo "uninstalling user services"

  if [ ! -d "$directory_path_systemd_user" ];
  then
    echo "creating ${directory_path_systemd_user} directory"

    mkdir -p $directory_path_systemd_user
  fi

  for service in $list_systemd_user
  do
    if echo $list_systemd_autostart | grep -q $service;
    then
      echo "disabling user service ${service} autostart"

      systemctl --user disable $service
    fi

    echo "uninstalling user service ${service}"

    rm $directory_path_systemd_user/$service
  done

  echo "reloading user services"

  systemctl --user daemon-reload
}

uninstall_scripts ()
{
  echo "uninstalling scripts"

  for bin in $list_scripts
  do
    echo "uninstalling ${bin} script"

    rm $directory_path_scripts/$bin
  done
}

uninstall_addons ()
{
  echo "uninstalling kodi addons"

  for addon in $list_addons
  do
    echo "uninstalling kodi ${addon} addon"

    rm -r $directory_path_kodi_addons/$addon
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
  echo "installing bluetooth drivers"

  # possibly install missing bluetooth 5 firmware
  # NOTE: binaries from 20201202_mpow_BH456A_driver+for+Linux.7z
  for firmware_binary_name in "rtl8761bu_fw" "rtl8761bu_config";
  do
    binary_path_bluetooth_main_firmware="/usr/lib/firmware/rtl_bt/$firmware_binary_name.bin"

    if [ ! -f "$binary_path_bluetooth_main_firmware" ];
    then
      echo "installing bluetooth driver ${firmware_binary_name}"

      sudo cp "$directory_path_this_script/firmware/$firmware_binary_name" "$binary_path_bluetooth_main_firmware"
    fi
  done
}

install_services_system ()
{
  echo "installing system service"

  for service in $list_systemd_system
  do
    echo "installing system service ${service}"

    sudo cp $directory_path_this_script/systemd/system/$service $directory_path_systemd_system

    sudo chmod 664 $directory_path_systemd_system/$service

    if echo $list_systemd_autostart | grep -q $service;
    then
      echo "enabling ${service} autostart"

      sudo systemctl enable $service
    fi
  done

  echo "reloading system services"

  sudo systemctl daemon-reload
}

install_services_user ()
{
  echo "installing user services"

  for service in $list_systemd_user
  do
    echo "installing user service ${service}"

    cp $directory_path_this_script/systemd/user/$service $directory_path_systemd_user

    if echo $list_systemd_autostart | grep -q $service;
    then
      echo "enabling ${service} autostart"

      systemctl --user enable $service
    fi
  done

  echo "reloading user services"

  systemctl --user daemon-reload
}

install_scripts ()
{
  echo "installing scripts"

  if [ ! -d "$directory_path_scripts" ];
  then
    echo "creating ${directory_path_scripts} directory"

    mkdir -p $directory_path_scripts
  fi

  for bin in $list_scripts
  do
    echo "installing script ${bin}"

    cp $directory_path_this_script/bin/$bin $directory_path_scripts
  done
}

install_addons ()
{
  echo "installing kodi addons"

  for addon in $list_addons
  do
    echo "installing kodi addon ${addon}"

    cp -r $directory_path_this_script/addons/$addon $directory_path_kodi_addons
  done
}

install_xsessions ()
{
  echo "installing xsessions"

  for session in $list_xsessions
  do
    echo "installing xsession ${session}"

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
