import xbmcaddon, xbmc, time

from utils import isDeviceState, connectDevice, writeFile

addon = xbmcaddon.Addon("script.bluetooth-devices-connector")

writeFile(addon.getAddonInfo('path') + "/devs.txt", addon.getSettingString("devs"))

