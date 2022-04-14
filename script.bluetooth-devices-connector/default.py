import xbmcaddon, xbmc, xbmcgui

from utils import connectDevice

addon = xbmcaddon.Addon("script.bluetooth-devices-connector")

devs = addon.getSettingString("devs").split(",")

def main():
	ok = xbmcgui.Dialog().ok("Connecting bluetooth devices", "Just make sure they're ready for pairing. \n" + str(devs))

	if not ok:
		return;

	report = ""

	for dev in devs:
		status = ""

		if connectDevice(dev, 4):
			status = "Connected"
		else:
			status = "Failed"

		report = report + dev + ": " + status + "\n"

	xbmcgui.Dialog().ok("Devices connection report:", report)

main()
