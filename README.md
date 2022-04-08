# kodi-respbian-addons
[Kodi](https://kodi.wiki/view/HOW-TO:Install_Kodi_on_Raspberry_Pi) addons on [Raspbian](https://www.raspberrypi.com/software/) environment

## Requirements
In this project it is assumed that kodi is launched from [lightDM](https://it.wikipedia.org/wiki/LightDM).

## Kodi at boot
According to the [documentation](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi/-/commit/7a371bfd9daf9b918a5d944cf1a04f71c37b387d), to launch kodi at system startup it is necessary to change the configuration of lightDM, usually found in `/etc/lightdm/lightdm.conf`, as follows:
```bash
autologin-user=pi # your user of choice
autologin-session=kodi # or kodi-standalone
```
