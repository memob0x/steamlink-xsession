import bluetooth
from random import sample
from os import path, environ
from xml.etree import ElementTree
from shutil import copyfile


def print_debug_log(string):
    if environ.get("BLUETOOTH_DEVICES_CONNECTOR_DEBUG") == "1":
        print(string)

    return string


def get_settings_bluetooth_devices_mac_list_from_xml(file_xml_path):
    devices_string = ""

    try:
        if path.exists(file_xml_path):
            tree = ElementTree.ElementTree(file=file_xml_path)
            root = tree.getroot()

            devices_string = root.find("setting[@id='devs']").text
    except Exception as e:
        print_debug_log("error reading xml: " + str(e))

    return devices_string.split(",")


def scan_bt_devices():
    print_debug_log("Trying to scan for nearby bluetooth devices...")

    try:
        bluetooth.discover_devices(
            duration=4,
            lookup_names=True,
            flush_cache=True,
            lookup_class=False
        )
    except Exception as e:
        print_debug_log(
            "Exception in scan_bt_devices function: " +
            str(e)
        )

    print_debug_log("Done scanning for nearby bluetooth devices.")


def get_devices_list_in_random_order():
    devices_mac = get_settings_bluetooth_devices_mac_list_from_xml(
        "/home/pi/.bluetooth-devices-connector-addon-settings.xml"
    )

    return sample(devices_mac, len(devices_mac))


def connect_to_bt_device(device_mac):
    sock = bluetooth.BluetoothSocket(bluetooth.RFCOMM)

    try:
        print_debug_log("Trying to connect to " + device_mac + "...")

        sock.connect((device_mac, 1))

        print_debug_log("Done with " + device_mac + " connection.")
    except Exception as e:
        print_debug_log(
            "Exception in connect_to_bt_device function: " +
            str(e)
        )


def main():
    print_debug_log("Copying devices list to temporary directory...")

    copyfile(
        "/home/pi/.kodi/userdata/addon_data/script.bluetooth-devices-connector/settings.xml",

        "/home/pi/.bluetooth-devices-connector-addon-settings.xml"
    )

    print_debug_log("Done copying devices list to temporary directory.")

    #scan_bt_devices()

    for device_mac in get_devices_list_in_random_order():
        if len(device_mac) <= 0:
            continue

        connect_to_bt_device(device_mac)

try:
    main()
except Exception as e:
    exit()
