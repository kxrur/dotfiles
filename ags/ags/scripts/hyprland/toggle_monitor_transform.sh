#!/bin/bash

# Get the current transform value of eDP-1
# current_transform=$(hyprctl monitors | grep "ID 0" | grep -oP "transform: \K\d")
current_transform=$(hyprctl monitors | grep -oP "transform: \K\d")

# Toggle between transform 0 and transform 2
if [ "$current_transform" -eq 0 ]; then
  hyprctl dispatch swapnext 0 # apply transform 2
  hyprctl keyword monitor "eDP-1,1920x1080@60,0x0,1,transform,2"
else
  hyprctl dispatch swapnext 1 # apply transform 0
  hyprctl keyword monitor "eDP-1,1920x1080@60,0x0,1,transform,0"
fi
