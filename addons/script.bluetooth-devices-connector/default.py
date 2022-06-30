import xbmcgui
import subprocess

xbmcgui.Dialog().ok(
    "Use this addon settings to save your devices mac addresses.",

    "They will be automatically connected as soon as they get reachable."
)

subprocess.call(
    "python /home/pi/.kodi/addons/script.bluetooth-devices-connector/staticize_settings.py",

    shell=True
)
