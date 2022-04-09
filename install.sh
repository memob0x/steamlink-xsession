DIR=$(readlink -f "$(dirname "$0")")

rm -rf ~/.kodi/addons/script.steamlink-launcher

cp -r $DIR/script.steamlink-launcher ~/.kodi/addons/
