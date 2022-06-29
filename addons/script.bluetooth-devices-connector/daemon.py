import bluetooth
from random import sample
from os import path, environ
from time import sleep
from subprocess import check_output
from multiprocessing import Process
from xml.etree import ElementTree
from shutil import copyfile


def print_debug_log(string):
    if environ.get("BLUETOOTH_DEVICES_CONNECTOR_DEBUG") == "1":
        print(string)

    return string


def execute_shell_command(command):
    try:
        output = check_output(command, shell=True)

        print_debug_log(
            "Function execute_shell_command produced output: " + output
        )

        return str(output)

    except Exception as e:
        print_debug_log(
            "Exception in execute_shell_command function: " + str(e)
        )

        return ""


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


def get_daemon_ps_list():
    daemon_pids_str_output = execute_shell_command(
        "pgrep -f \"script.bluetooth-devices-connector/daemon.py\""
    )

    daemon_pids_list = daemon_pids_str_output.split("\n")

    daemon_pids_list = map(
        lambda x: execute_shell_command("ps " + x),

        daemon_pids_list
    )

    daemon_pids_list = [i for i in daemon_pids_list if i]

    for pid in daemon_pids_list:
        print_debug_log("Daemon process detected: " + pid)

    return daemon_pids_list


def is_daemon_already_running():
    return len(get_daemon_ps_list()) > 0


def launch_daemon_copy_xml_loop():
    while True:
        print_debug_log("Copying devices list to temporary directory...")

        copyfile(
            "/home/pi/.kodi/userdata/addon_data/script.bluetooth-devices-connector/settings.xml",

            "/tmp/bluetooth-devices-connector-addon-settings.xml"
        )

        print_debug_log("Done copying devices list to temporary directory.")

        sleep(12)


def scan_bt_devices():
    print_debug_log("Trying to scan for nearby bluetooth devices...")

    try:
        bluetooth.discover_devices(
            duration=12,
            lookup_names=True,
            flush_cache=True,
            lookup_class=False
        )
    except Exception as e:
        print_debug_log(
            "Exception in launch_daemon_scan_loop function: " +
            str(e)
        )

    print_debug_log("Done scanning for nearby bluetooth devices.")


def launch_daemon_scan_loop():
    while True:
        scan_bt_devices()


def get_devices_list_in_random_order():
    devices_mac = get_settings_bluetooth_devices_mac_list_from_xml(
        "/tmp/bluetooth-devices-connector-addon-settings.xml"
    )

    return sample(devices_mac, len(devices_mac))


def connect_to_bt_device(device_mac):
    sock = bluetooth.BluetoothSocket(bluetooth.RFCOMM)

    try:
        print_debug_log("Trying to connect to " + device_mac + "...")

        sock.connect((device_mac, 1))

        print_debug_log("Done with " + device_mac + " connection.")

        # 0x1X for straight forward and 0x11 for very slow to 0x1F for fastest
        sock.send("\x1A")
    except Exception as e:
        print_debug_log(
            "Exception in launch_daemon_connection_loop function: " +
            str(e)
        )

    sock.recv(1024)


def launch_daemon_connection_loop():
    while True:
        for device_mac in get_devices_list_in_random_order():
            if len(device_mac) <= 0:
                continue

            print_debug_log("Loop attempting to connect " + device_mac)

            connect_to_bt_device(device_mac)


if is_daemon_already_running():
    print_debug_log("Daemon is already running, exit")

    exit()

print_debug_log("Daemon is not running, launch")

p0 = Process(target=launch_daemon_copy_xml_loop)
p0.start()

p1 = Process(target=launch_daemon_scan_loop)
p1.start()

p2 = Process(target=launch_daemon_connection_loop)
p2.start()

p0.join()
p1.join()
p2.join()
