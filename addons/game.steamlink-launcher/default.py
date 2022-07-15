import xbmc
import subprocess

xbmc.executebuiltin('ActivateWindow(busydialognocancel)')

subprocess.call([
  "sudo",

  "systemctl",

  # "--user",

  "start",

  "steamlink.service",
])
