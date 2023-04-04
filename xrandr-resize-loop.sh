#!/bin/sh

# This script will resize the screen to the 'auto' every screensize change
# only really for use in VM

# Just make sure not running too early
sleep 5

OUTPUT=$(xrandr | awk '/ connected/{print $1; exit; }')

xrandr --output "$OUTPUT" --auto

xev -root -event randr |
    grep --line-buffered 'subtype XRROutputChangeNotifyEvent' |
    while read -r _; do
        #+ is prefered resolution
        RESOLUTION=$(xrandr | awk '/\+/{print $1}' | sed -n 2p | cut -d 'x' -f1,2)
        echo "Screen resolution changing to $RESOLUTION"
        xrandr --output "$OUTPUT" --auto
    done
