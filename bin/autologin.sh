#!/bin/sh

file_path_lightdm_config=/etc/lightdm/lightdm.conf

string_lightdm_config_mark_suffix="autologin"
string_lightdm_config_mark_suffix_start="$string_lightdm_config_mark_suffix-start"
string_lightdm_config_mark_suffix_end="$string_lightdm_config_mark_suffix-end"

script_argument_primary="$1"
script_argument_secondary="$2"

if [ "$script_argument_primary" = "uninstall" ]
then
  sudo sh -c "perl -0777 -pi -e 's/#$string_lightdm_config_mark_suffix_start.*#$string_lightdm_config_mark_suffix_end//gs' $file_path_lightdm_config"
fi

if [ "$script_argument_primary" = "install" ]
then
  sudo sh -c "echo '#$string_lightdm_config_mark_suffix_start' >> $file_path_lightdm_config"
  sudo sh -c "echo '[Seat:*]' >> $file_path_lightdm_config"
  sudo sh -c "echo 'autologin-user=pi' >> $file_path_lightdm_config"
  sudo sh -c "echo 'autologin-session=$script_argument_secondary' >> $file_path_lightdm_config"
  sudo sh -c "echo '#$string_lightdm_config_mark_suffix_end' >> $file_path_lightdm_config"
fi

# removes extra ending new line (probably left by perl)
# otherwise new lines would increase indefinitely with the use of this script
sudo sh -c "sed -zi 's/\n$//' $file_path_lightdm_config >> $file_path_lightdm_config"
