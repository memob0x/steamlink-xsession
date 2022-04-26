import xbmcaddon, xbmc, xbmcgui

from connect import connect

addon = xbmcaddon.Addon("script.bluetooth-devices-connector")

devs = addon.getSettingString("devs").split(",")

def main():
	ok = xbmcgui.Dialog().ok("Connecting to bluetooth devices", "Just make sure they're ready for pairing. \n" + str(devs))

	if not ok:
		return;

	report = connect(devs)

	xbmcgui.Dialog().ok("Devices connection report:", report)

main()
