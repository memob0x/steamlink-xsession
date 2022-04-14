import xbmcaddon, xbmc, time

from utils import isDeviceState, connectDevice

addon = xbmcaddon.Addon("script.bluetooth-devices-connector")

devs = addon.getSettingString("devs").split(",")

xbmc.executebuiltin('XBMC.Notification(1,1b executed,10)')

for dev in devs:
	if not isDeviceState("Connected", dev):
		connectDevice(dev, 0)
