import os
import xbmc
import xbmcgui
import xbmcaddon

__plugin__ = "emustation-launcher"
__author__ = "toast"
__url__ = "https://github.com/memob0x/osmc-emustation-addons/"
__git_url__ = "https://github.com/memob0x/osmc-emustation-addons/"
__credits__ = "toast"
__version__ = "0.0.1"

dialog = xbmcgui.Dialog()
addon = xbmcaddon.Addon(id='plugin.program.emustation-launcher')

with open('/tmp/emustation-launcher.sh', 'w') as outfile:
        outfile.write("""#!/bin/bash

cp launcher.sh /tmp/emustation-launcher.sh

chmod 755 /tmp/emustation-launcher.sh

exit

""")

        outfile.close()

output = os.popen("sh /tmp/emustation-launcher.sh").read()
