# Raspbian Scripts

Basically a collection of scripts I use to setup [Raspbian](https://www.raspberrypi.com/software/) environments with [Kodi](https://kodi.wiki/view/HOW-TO:Install_Kodi_on_Raspberry_Pi), Steamlink, TvHeadEnd etc...

The project is designed to work with Kodi 19 on top of Raspbian [bullseye](https://www.raspberrypi.com/news/raspberry-pi-os-debian-bullseye/) with LightDM as display manager.

## Features
- **kodi startup at boot**
- **kodi steamlink launcher addon**: since steamlink is not compatible with X server, this addon switches off the display manager and runs steamlink, then, on steamlink exit, restarts it
- **kodi bluetooth pairing addon**: connects your devices MAC address; comes with a systemd timer which automatically reconnects them when they go off, quite handy for game controllers

## Installation

1. Install the required dependencies.

   ```bash
   sudo apt install kodi kodi-peripheral-joystick steamlink tvheadend
   ```

2. Run the installation script.

   ```bash
   sh install.sh
   ```

2. Activate the addons from Kodi GUI.
