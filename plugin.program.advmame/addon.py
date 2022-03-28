"""advmame Launcher for OSMC"""
import os
import xbmc
import xbmcgui
import xbmcaddon

__plugin__ = "advmame"
__author__ = "toast"
__url__ = "https://github.com/memob0x/osmc-advmame-launcher/"
__git_url__ = "https://github.com/memob0x/osmc-advmame-launcher/"
__credits__ = "toast"
__version__ = "0.0.1"

dialog = xbmcgui.Dialog()
addon = xbmcaddon.Addon(id='plugin.program.advmame')

output = os.popen("sh ./launch-emustation.sh").read()

dialog.ok("Starting Emulation Station...", output)
