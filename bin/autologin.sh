#!/bin/sh

file_path_lightdm_config=/etc/lightdm/lightdm.conf

string_lightdm_config_mark_suffix="autologin"
string_lightdm_config_mark_suffix_start=$string_lightdm_config_mark_suffix"-start"
string_lightdm_config_mark_suffix_end=$string_lightdm_config_mark_suffix"-end"

script_argument_primary="$1"
script_argument_secondary="$2"

uninstall(){
  sudo sh -c "perl -0777 -pi -e 's/^\n//gsm' $file_path_lightdm_config"

  sudo sh -c "perl -0777 -pi -e 's/#$string_lightdm_config_mark_suffix_start.*#$string_lightdm_config_mark_suffix_end//gsm' $file_path_lightdm_config"
}

sudo cp $file_path_lightdm_config $file_path_lightdm_config.backup

if [ "$script_argument_primary" = "uninstall" ]
then
  uninstall

  exit 0
fi

if [ "$script_argument_primary" = "install" ]
then
  uninstall

  sudo sh -c "echo '\n' >> $file_path_lightdm_config"

  sudo sh -c "echo '#$string_lightdm_config_mark_suffix_start' >> $file_path_lightdm_config"

  sudo sh -c "echo '[Seat:*]' >> $file_path_lightdm_config"

  sudo sh -c "echo autologin-user=$(whoami) >> $file_path_lightdm_config"

  sudo sh -c "echo autologin-session=$script_argument_secondary >> $file_path_lightdm_config"

  sudo sh -c "echo '#$string_lightdm_config_mark_suffix_end' >> $file_path_lightdm_config"

  sudo sh -c "echo '\n' >> $file_path_lightdm_config"

  exit 0
fi

echo "Invalid argument supplied."

exit 1
