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
            "Function execute_shell_command returned error: " + str(e)
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
    # NOTE:
    # 1: the process itself that might be already running
    # 2: the process + the pgrep command
    # 3: not valid, 1 process and 1 pgrep
    # TODO: should probably improve this with a process exact match (maybe through absolute paths?)
    return len(get_daemon_ps_list()) > 2

def launch_daemon_copy_xml_loop():
    while True:
        copyfile(
            "/home/pi/.kodi/userdata/addon_data/script.bluetooth-devices-connector/settings.xml",

            "/tmp/bluetooth-devices-connector-addon-settings.xml"
        )

        sleep(12)

def launch_daemon_scan_loop():
    while True:
        execute_shell_command("sudo -u pi -E bluetoothctl scan on")

        sleep(5)

        execute_shell_command("sudo -u pi -E bluetoothctl scan off")

        sleep(1)


def launch_daemon_connection_loop():
    while True:
        devices_mac = get_settings_bluetooth_devices_mac_list_from_xml(
            "/tmp/bluetooth-devices-connector-addon-settings.xml"
        )

        devices_mac_in_random_order = sample(devices_mac, len(devices_mac))

        for device_mac in devices_mac_in_random_order:
            if len(device_mac) <= 0:
                continue

            device_informations = execute_shell_command(
                "sudo -u pi -E bluetoothctl info" + device_mac
            )

            for bluetooth_command_arguments in [
                ["trust", "Trusted"],

                ["pair", "Paired"],

                ["connect", "Connected"]
            ]:
                bluetooth_command_action, bluetooth_command_expected_state = bluetooth_command_arguments

                if bluetooth_command_expected_state + ": yes" in device_informations:
                    print_debug_log(
                        "Device (" +

                        device_mac +

                        ") was already in state: " +

                        bluetooth_command_expected_state
                    )
                else:
                    execute_shell_command(
                        "sudo -u pi -E bluetoothctl " + bluetooth_command_action + " " + device_mac
                    )

        sleep(1)


if is_daemon_already_running():
    print_debug_log("Daemon is already running, exit")

    exit()

print_debug_log("Daemon is not running, launch")

# TODO: should execute the following commands too
# sudo -u pi -E bluetoothctl power on
# sudo -u pi -E bluetoothctl pairable on
# sudo -u pi -E bluetoothctl discoverable on

p0 = Process(target=launch_daemon_copy_xml_loop)
p0.start()

p1 = Process(target=launch_daemon_scan_loop)
p1.start()

p2 = Process(target=launch_daemon_connection_loop)
p2.start()

p0.join()
p1.join()
p2.join()
