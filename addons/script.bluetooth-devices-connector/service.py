import xbmcaddon, xbmc, time

from utils import deleteFile, writeFile

addon = xbmcaddon.Addon("script.bluetooth-devices-connector")

file = addon.getAddonInfo('path') + "/devs.txt"

deleteFile(file)

devs_raw = addon.getSettingString("devs")

writeFile(file, devs_raw)
