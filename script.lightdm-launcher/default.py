import xbmcaddon
import subprocess

ADDON = xbmcaddon.Addon()

CWD = ADDON.getAddonInfo('path')

subprocess.call(["sh", CWD + "/launcher.sh"])
