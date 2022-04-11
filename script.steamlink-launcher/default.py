import subprocess
import xbmcaddon, xbmc

addon = xbmcaddon.Addon()

def launch():
	xbmc.executebuiltin('ActivateWindow(busydialognocancel)')

	subprocess.call(["sudo", "service", "steamlink", "start"])

launch()
