import xbmc, subprocess

xbmc.executebuiltin('ActivateWindow(busydialognocancel)')

subprocess.call(["sudo", "service", "steamlink", "start"])
