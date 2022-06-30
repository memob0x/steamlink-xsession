from xml.etree import ElementTree


devices_string = ""

try:
    tree = ElementTree.ElementTree(
        file="/home/pi/.kodi/userdata/addon_data/script.bluetooth-devices-connector/settings.xml"
    )

    root = tree.getroot()

    devices_string = root.find("setting[@id='devs']").text
except Exception as e:
    print("error reading xml: " + str(e))

f = open("/home/pi/.kodi/userdata/addon_data/script.bluetooth-devices-connector/devices", "a")

f.write(devices_string.replace(",", " ", -1))

f.close()
