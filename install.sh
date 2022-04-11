DIR=$(readlink -f "$(dirname "$0")")

# kodi addon installation

rm -rf ~/.kodi/addons/script.steamlink-launcher

cp -r $DIR/script.steamlink-launcher ~/.kodi/addons/

# steamlink systemd service installation

sudo rm /etc/systemd/system/steamlink.service

sudo cp $DIR/steamlink.service /etc/systemd/system/

sudo chmod 664 /etc/systemd/system/steamlink.service

sudo systemctl daemon-reload

# bt refresher addon installation

rm -rf ~/.kodi/addons/script.bt-devices-connector

cp -r $DIR/script.bt-devices-connector ~/.kodi/addons/
