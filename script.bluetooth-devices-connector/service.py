import xbmcaddon, xbmc, xbmcgui, time

from utils import isDeviceState, connectDevice

addon = xbmcaddon.Addon()

devs = addon.getSettingString("devs").split(",")

def checkDevs():
	for dev in devs:
		if not isDeviceState("Connected", dev):
			if connectDevice(dev, 0):
				xbmc.executebuiltin('Notification(Bluetooth device connected,' + dev + ',5000)')

checkDevs()

while True:
	checkDevs()

	time.sleep(60)
