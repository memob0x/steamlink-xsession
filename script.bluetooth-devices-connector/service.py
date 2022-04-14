import xbmcaddon, xbmc, time

from utils import isDeviceState, connectDevice

addon = xbmcaddon.Addon()

devs = addon.getSettingString("devs").split(",")

for dev in devs:
	if not isDeviceState("Connected", dev):
		connectDevice(dev, 0)
