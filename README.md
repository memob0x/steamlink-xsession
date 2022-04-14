# RKMC

RKMD stands for Raspbian Kodi Media Center, which basically consists in my personal setup script for a
[Kodi](https://kodi.wiki/view/HOW-TO:Install_Kodi_on_Raspberry_Pi)-first [Raspbian](https://www.raspberrypi.com/software/) environment.

## Requirements
- Raspbian [bullseye](https://www.raspberrypi.com/news/raspberry-pi-os-debian-bullseye/)

## Features
- kodi startup at boot
- kodi chromium launcher addon
- kodi steamlink launcher addon
- kodi bluetooth pairing addon
- some other script and services goodies

## Installation

1. Install the required dependencies.

   ```bash
   sudo apt install kodi kodi-eventclients-kodi-send snapd steamlink
   
   sudo snap install core
   ```

2. Run the installation script.

   ```bash
   sh install.sh
   ```
2. Activate the addons from Kodi GUI.
