#!/bin/sh

command=$1

instruction=$2

if [ $(echo $instruction | grep -c "=") = "0" ];
then
  echo "Invalid instruction ${instruction} supplied to command."

  exit 1
fi

property=$(echo $instruction | cut -d '=' -f1)

value=$(echo $instruction | cut -d '=' -f2)

if [ ! $property ] || [ ! $value ];
then
  echo "At least one missing argument supplied command."

  exit 1
fi

boot_config_file=/boot/config.txt

set_unique_property(){
  if [ $(cat $boot_config_file | grep -c "${property}=") = "1" ];
  then
    echo "Property ${property} found, replacing it with property \"${property}\" with value \"${value}\"..."

    sudo sed -i "s/${property}=.*/${property}=${value}/" $boot_config_file

    return
  fi

  echo "Setting property \"${property}\" with value \"${value}\""

  echo $instruction | sudo tee -a $boot_config_file
}

set_unique_property_and_value(){
  if [ $(cat $boot_config_file | grep -c "${property}=${value}") = "1" ];
  then
    echo "Property ${property} with value ${value} found, nothing to do..."

    return
  fi

  echo $instruction | sudo tee -a $boot_config_file
}

if [ "${command}" = "set_unique_property" ];
then
  set_unique_property

  exit 0
fi

if [ "${command}" = "set_unique_property_and_value" ];
then
  set_unique_property_and_value

  exit 0
fi

echo "Invalid command ${command} argument."

exit 1
