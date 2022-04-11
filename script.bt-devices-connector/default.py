import xbmcaddon, xbmc, xbmcgui

from utils import connectDevice

addon = xbmcaddon.Addon()

devs = addon.getSettingString("devs").split(",")

def main():
	ok = xbmcgui.Dialog().ok("Connecting bluetooth devices", "Just make sure they're ready for pairing. \n" + str(devs))

	if not ok:
		return;

	report = ""

	for dev in devs:
		result = connectDevice(dev, 4)

		status = ""

		if result:
			status = "Connected"
		else:
			status = "Failed"

		report = report + dev + ": " + status + " (Result: " + str(result) + ")\n"

	xbmcgui.Dialog().ok("Refresh report:", report)

main()
