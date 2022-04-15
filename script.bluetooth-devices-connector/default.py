import xbmcaddon, xbmc, xbmcgui

from utils import connectDevice

addon = xbmcaddon.Addon("script.bluetooth-devices-connector")

devs = addon.getSettingString("devs").split(",")

def getReport(dev, status):
	return dev + ": " + status

def main():
	ok = xbmcgui.Dialog().ok("Connecting bluetooth devices", "Just make sure they're ready for pairing. \n" + str(devs))

	if not ok:
		return;

	report = ""

	def onSuccess(d):
		nonlocal report

		report = report + getReport(d, "Success")

	def onError(d):
		nonlocal report

		report = report + getReport(d, "Failed")

	connectDevice(devs, 4, onSuccess, onError)

	xbmcgui.Dialog().ok("Devices connection report:", report)

main()
