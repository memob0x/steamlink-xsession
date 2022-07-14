#!/bin/sh

command=$1

instruction=$2

boot_config_file=/boot/config.txt

set_property_value(){
  if [ $(echo $instruction | grep -c "=") = "0" ];
  then
    echo "Invalid instruction supplied to \"set\" command."

    exit 1
  fi

  property=$(echo $instruction | cut -d '=' -f1)
  value=$(echo $instruction | cut -d '=' -f2)

  if [ ! $property ] || [ ! $value ];
  then
    echo "At least one missing argument supplied \"set\" command."

    exit 1
  fi

  if [ $(cat $boot_config_file | grep -c "${property}=") = "1" ];
  then
    echo "Property ${property} found, replacing it with property \"${property}\" with value \"${value}\"..."

    sudo sed -i "s/${property}=.*/${property}=${value}/" $boot_config_file

    exit 0
  fi

  echo "Setting property \"${property}\" with value \"${value}\""

  echo $instruction | sudo tee -a $boot_config_file

  exit 0
}

if [ "${command}" = "set" ];
then
  set_property_value
fi

echo "Invalid command argument."

exit 1
