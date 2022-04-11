# kodi-respbian-addons
[Kodi](https://kodi.wiki/view/HOW-TO:Install_Kodi_on_Raspberry_Pi) addons on [Raspbian](https://www.raspberrypi.com/software/) environment

## Requirements
In this project it is assumed that kodi is launched from [lightDM](https://it.wikipedia.org/wiki/LightDM).

## Installation

Run the installation script.

```
sh install.sh
```

## Extra

### Kodi at boot
According to the current [specifications](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi/-/commit/7a371bfd9daf9>```bash
autologin-user=pi # your user of choice
autologin-session=kodi # or kodi-standalone
```
