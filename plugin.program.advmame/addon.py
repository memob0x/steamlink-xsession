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
__version__ = "0.0.12"

dialog = xbmcgui.Dialog()
addon = xbmcaddon.Addon(id='plugin.program.advmame')

def main():
    """Main operations of this plugin."""
    output = os.popen("sh /tmp/advmame-launcher.sh").read()
    dialog.ok("Starting mslugx...", output)

def create_files():
    """Creates bash files to be used for this plugin."""
    with open('/tmp/advmame-launcher.sh', 'w') as outfile:
        outfile.write("""#!/bin/bash
advmame mslugx"
""")
        outfile.close()
main()
