# steamlink-standalone

Run steamlink without a window manager.

## Constraints

This project has been tested on a Raspberry Pi 3 default installation only, which should consist in [Raspbian](https://www.raspberrypi.com/software/) Bullseye with LightDM as display manager, and "pi" as the default user.

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

## Features

- **autologin shell script**: changes lightdm autologin

   `install` sets the given xsession name as autologin.

   ```
   sh ~/bin/autologin.sh install steamlink
   ```

   It can be used with any valid session name.

   ```
   sh ~/bin/autologin.sh install your_xsession_of_choice
   ```

   `uninstall` removes any previously set xsession autologin.

   ```
   sh ~/bin/autologin.sh uninstall
   ```

- **boot shell script**: edits `/boot/config.txt` properties

   `set_unique_property` ensures only one property with the given name is set

   The following command results in a single "foo" property in the whole config.txt file.

   ```
   sh ~/bin/boot.sh set_unique_property foo=bar
   ```

   `set_unique_property_and_value` ensures only one property with the given name and value is set

   The following command might results in multiple "foo" properties with different values, but only one with "bar" as value in the whole config.txt file.

   ```
   sh ~/bin/boot.sh set_unique_property_and_value foo=bar
   ```
   
- **steamlink shell script**: handles steamlink execution

   `launch` ensures steamlink starts, switches off the window manager and runs steamlink.

   It also automatically set steamlink as autologin xsession on service start in order to resume the steamlink session on unhandled system shutdown.

   ```
   sh ~/bin/steamlink.sh launch
   ```

   `kill` ensures steamlink exists

   ```
   sh ~/bin/steamlink.sh kill
   ```

- **steamlink xsession**: in order to let steamlink to be set as "autologin" session

- **steamlink service**: a systemd steamlink shell script shortcut

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

## Extra

For optimal performance disabling wi-fi module is suggested, it can be achieved by adding the following line to the `/boot/config.txt` file.

```
dtoverlay=disable-wifi
```
