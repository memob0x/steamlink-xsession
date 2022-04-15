import subprocess

def launchEnv(env):
	subprocess.call(["sh", "/home/pi/bin/set-lightdm-autologin.sh", env])

	subprocess.call(["sudo", "service", "lightdm", "restart"])

def launchKioskBrowser():
	launchEnv("kiosk-browser")

def launchKodi():
	launchEnv("kodi")
