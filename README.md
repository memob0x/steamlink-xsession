# steamlink-standalone

Run steamlink without a window manager.

## Installation

Launch the setup script with _install_ argument

```
sh setup.sh install
```

## Uninstallation

Launch the setup script with _uninstall_ argument

```
sh setup.sh uninstall
```

## Extra

For optimal performance disabling wi-fi module is suggested, it can be achieved by adding the following line to the `/boot/config.txt` file.
```
dtoverlay=disable-wifi
```

## Features

- **autologin script**: changes lightdm autologin

   ```
   sh ~/bin/autologin.sh steamlink
   sh ~/bin/autologin.sh your_xsession_of_choice
   ```

- **boot script**: adds/edits `/boot/config.txt` properties

   ```
   sh ~/bin/boot.sh set_unique_property foo=bar # ensures only one "foo" property is set
   sh ~/bin/boot.sh set_unique_property_and_value foo=bar # ensures only one "foo=bar" property is set
   ```

- **steamlink xsession**: in order to let steamlink to be set as "autologin" session

- **steamlink service**: switches off the window manager and runs steamlink, then, on steamlink exit, restart the window manager.

   It also automatically set steamlink as autologin xsession on service start in order to resume the steamlink session on unhandled system shutdown.

   ```
   systemctl stop steamlink.service
   systemctl stop steamlink.service
   systemctl status steamlink.service
   journalctl -e -b -u steamlink.service
   ```

- **bluetooth 5 firmware files**: under Raspbian Bullseye these drivers are not present, since they are not easily discoverable online, these files are handled by the _setup_ script during the installation process.

   Please note that the following binary files are automatically installed on _setup install_ if they are not present, but never removed on _setup uninstall_, in order to not interfer with a possible previous user manual installation.

   ```
   ls /usr/lib/firmware/rtl_bt/rtl8761bu_config.bin
   ls /usr/lib/firmware/rtl_bt/rtl8761bu_fw.bin
   ```

   The following line is also automatically added to `/boot/config.txt` file (and not removed on uninstall) in order to force the system to use the forsaid bluetooth drivers only.

   `dtoverlay=disable-bt`
