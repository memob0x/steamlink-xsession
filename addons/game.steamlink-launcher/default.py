import xbmc
import subprocess

xbmc.executebuiltin('ActivateWindow(busydialognocancel)')

subprocess.call(["systemctl", "--user", "start", "steamlink.service"])
