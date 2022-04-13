import xbmc, subprocess

xbmc.executebuiltin('ActivateWindow(busydialognocancel)')

subprocess.call(["sudo", "service", "kiosk-browser", "start"])
