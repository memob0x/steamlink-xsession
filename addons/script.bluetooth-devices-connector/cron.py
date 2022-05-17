from os.path import dirname, exists

from utils import log, logSeparator
from connect import connect

import xml.etree.ElementTree as ET

logSeparator()

log(__file__ + " start")

cwd = dirname(__file__)

devs_raw = ""

filexml = "/home/pi/.kodi/userdata/addon_data/script.bluetooth-devices-connector/settings.xml"

if exists(filexml):
	tree = ET.ElementTree(file=filexml)
	root = tree.getroot()

	devs_raw = root.find("setting[@id='devs']").text

connect(devs_raw.split(","))

log(__file__ + " end")
