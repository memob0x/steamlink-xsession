from os.path import dirname, exists

from utils import readFile, writeFile, connectDevice

import xml.etree.ElementTree as ET

cwd = dirname(__file__)

devs_raw = ""

filetxt = cwd + "/devs.txt"

filexml = "/home/pi/.kodi/userdata/addon_data/script.bluetooth-devices-connector/settings.xml"

if exists(filetxt):
	devs_raw = readFile(filetxt)
elif exists(filexml):
	tree = ET.ElementTree(file=filexml)
	root = tree.getroot()

	devs_raw = root.find("setting[@id='devs']").text

	writeFile(filetxt, devs_raw)

connectDevice(devs_raw.split(","))
