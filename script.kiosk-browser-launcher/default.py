import xbmc
from utils import launchKioskBrowser

xbmc.executebuiltin('ActivateWindow(busydialognocancel)')

launchKioskBrowser()
