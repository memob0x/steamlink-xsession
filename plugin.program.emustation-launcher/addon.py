import xbmc
import xbmcaddon
import subprocess

__plugin__ = "emustation-launcher"
__author__ = "toast"
__url__ = "https://github.com/memob0x/kodi-retropie-addons/"
__git_url__ = "https://github.com/memob0x/kodi-retropie-addons/"
__credits__ = "toast"
__version__ = "0.0.1"

xbmcaddon.Addon(id='plugin.program.emustation-launcher')

subprocess.call(["sh", "~/.kodi/addons/plugin.program.emustation-launcher/launcher.sh"])
