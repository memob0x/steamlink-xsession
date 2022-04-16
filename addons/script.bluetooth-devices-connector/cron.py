from os.path import dirname, exists

from utils import readFile, writeFile, connectDevice

import xml.etree.ElementTree as ET

cwd = dirname(__file__)

devs_raw = ""

file = cwd + "/devs.txt"

if exists(file):
	devs_raw = readFile(file)
else:
	tree = ET.ElementTree(file='/home/pi/.kodi/userdata/addon_data/script.bluetooth-devices-connector/settings.xml')
	root = tree.getroot()

	devs_raw = root.find("setting[@id='devs']").text

	writeFile(file, devs_raw)

connectDevice(devs_raw.split(","))
