# Raspbian Scripts

Basically a collection of scripts I use to setup media-center [Raspbian](https://www.raspberrypi.com/software/) environments, with:
- [Kodi](https://kodi.wiki/view/HOW-TO:Install_Kodi_on_Raspberry_Pi)
- [Steamlink](https://store.steampowered.com/app/353380/Steam_Link/)
- [TvHeadEnd](https://tvheadend.org/)
- [Goodies](#features)

## Constraints

The project is designed to work with Kodi 19 on top of Raspbian [bullseye](https://www.raspberrypi.com/news/raspberry-pi-os-debian-bullseye/) with LightDM as display manager, and "pi" as the default user.

## Installation

   1. Install the required system dependencies

      ```
      sudo apt install kodi kodi-peripheral-joystick joystick steamlink tvheadend
      ```

   2. Launch the setup script with _install_ argument

      ```
      sh setup.sh install
      ```

   3. Activate the kodi addons from its GUI.

## Uninstallation

Launch the setup script with _uninstall_ argument

```
sh setup.sh uninstall
```

## Features

- **autologin script**: changes lightdm autologin with ease

   ```
   sh ~/bin/autologin.sh kodi
   sh ~/bin/autologin.sh steamlink
   sh ~/bin/autologin.sh your_xsession_of_choice
   ```

- **steamlink xsession**: in order to let steamlink to be set as "autologin" session

- **steamlink service**: since steamlink is not compatible with X server, this service switches off the display manager and runs steamlink, then, on steamlink exit, restarts it.

   It also automatically set steamlink as autologin xsession on service start and kodi on service stop, in order to resume the steamlink session on unhandled system shutdown.

   ```
   systemctl stop steamlink.service
   systemctl stop steamlink.service
   systemctl status steamlink.service
   journalctl -e -b -u steamlink.service
   ```

- **kodi steamlink launcher addon**: allows the steamlink service to be launched from kodi

- **bluetooth 5 firmware files**: under Raspbian Bullseye these drivers are not present, since they are not easily discoverable online, these files are handled by the _setup_ script during the installation process.

   Please note that the following binary files are automatically installed on _setup install_ if they are not present, but never removed on _setup uninstall_, in order to not interfer with a possible previous user manual installation.

   ```
   ls /usr/lib/firmware/rtl_bt/rtl8761bu_config.bin
   ls /usr/lib/firmware/rtl_bt/rtl8761bu_fw.bin
   ```
