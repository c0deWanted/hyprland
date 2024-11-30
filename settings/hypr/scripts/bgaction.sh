#!/bin/bash

image_tuxedo=$(find ~/Pictures/Backgrounds/Gruvbox_Wallapaper -type f -print0 | shuf -zn 1)
image_dell=$(find ~/Pictures/Backgrounds/Gruvbox_Wallapaper -type f -print0 | shuf -zn 1)
swaybg -o eDP-1 -i "$image_tuxedo" &
swaybg -o HDMI-A-1 -i "$image_dell" &
