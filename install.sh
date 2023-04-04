#!/bin/sh
set -e

DESKTOPFILE="auto-manual-resize.desktop"
SCRIPT="xrandr-resize-loop.sh"

getIfMissing() {
    if [ ! -e "$1" ]; then
        echo "Downloading $1"
        wget -q "https://raw.githubusercontent.com/RyanCarrier/auto-manual-resize/master/$1"
    fi
    chmod a+rx "$1"
}

getIfMissing "$SCRIPT"
getIfMissing "$DESKTOPFILE"

echo "Moving files"
mkdir -p ~/.config/autostart
mv "$SCRIPT" ~/.config/
mv "$DESKTOPFILE" ~/.config/autostart/
echo "Log out then back in to start the script"
