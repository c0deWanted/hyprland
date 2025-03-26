#!/bin/bash
#
#Hyprland Warm Theme
#
# General
hyprctl keyword general:border_size 0
hyprctl keyword general:gaps_in 5
hyprctl keyword general:gaps_out 5
hyprctl keyword general:col.active_border 0xffffbf00 0xffdf6900 120deg
hyprctl keyword general:col.inactive_border 0x64ffbf00 0x64df6900 90deg
hyprctl keyword general:layout dwindle
hyprctl keyword general:resize_on_border true

# Decoration
hyprctl keyword decoration:rounding 16
hyprctl keyword decoration:dim_inactive false
hyprctl keyword decoration:dim_strength 0.2
hyprctl keyword decoration:dim_special 0.3
hyprctl keyword decoration:active_opacity 0.9
hyprctl keyword decoration:inactive_opacity 0.8
hyprctl keyword decoration:fullscreen_opacity 1.0

# Decoration Blur
hyprctl keyword decoration:blur:enabled true
hyprctl keyword decoration:blur:size 2
hyprctl keyword decoration:blur:passes 3
hyprctl keyword decoration:blur:new_optimizations true
hyprctl keyword decoration:blur:xray false

# Misc
hyprctl keyword misc:disable_hyprland_logo true
hyprctl keyword misc:animate_manual_resizes true
hyprctl keyword misc:animate_mouse_windowdragging false
