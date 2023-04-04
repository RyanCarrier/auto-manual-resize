#!/bin/sh
set -e
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run as root." >&2
    exit 1
fi

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
mv "$SCRIPT" /usr/local/bin/
mv "$SERVICE" /etc/systemd/system/
echo "Starting service $SERVICE"
systemctl daemon-reload
systemctl enable "$SERVICE" --now
