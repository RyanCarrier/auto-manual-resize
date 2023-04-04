#!/bin/sh
set -e

SERVICE="auto-manual-resize.service"
SCRIPT="xrandr-resize-loop.sh"

getIfMissing() {
    if [ ! -e "$1" ]; then
        echo "Downloading $1"
        wget -q "https://raw.githubusercontent.com/RyanCarrier/auto-manual-resize/master/$1"
    fi
    chmod a+rx "$1"
}

getIfMissing "$SCRIPT"
getIfMissing "$SERVICE"

echo "Moving files"
mv "$SCRIPT" ~/.config/
mv "$SERVICE" ~/.config/systemd/user/
echo "Starting service $SERVICE"
systemctl --user enable "$SERVICE" --now
