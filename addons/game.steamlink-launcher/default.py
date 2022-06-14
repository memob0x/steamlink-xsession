import xbmc
import subprocess

xbmc.executebuiltin('ActivateWindow(busydialognocancel)')

subprocess.call(["sudo", "service", "steamlink", "start"])
