import xbmcaddon, xbmc, time

from utils import deleteFile, writeFile, disconnectDevice, connectDevice

addon = xbmcaddon.Addon("script.bluetooth-devices-connector")

file = addon.getAddonInfo('path') + "/devs.txt"

deleteFile(file)

devs = addon.getSettingString("devs")

writeFile(file, devs)

disconnectDevice(devs)

connectDevice(devs)
