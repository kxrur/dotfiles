#!/bin/bash

# Get the current monitor setup using hyprctl
monitors=$(hyprctl monitors all -j) # -j gives JSON output

# Check if the external monitor is disabled (replace with your external monitor's name)
external_monitor_name="DP-1" # Example external monitor name, update this accordingly
laptop_monitor_name="eDP-1"  # Example laptop monitor name, update this accordingly

# Extract the status of the external monitor
external_status=$(echo "$monitors" | jq -r ".[] | select(.name==\"$external_monitor_name\") | .enabled")

# If external monitor is disabled, enable the laptop monitor
if [ "$external_status" = "false" ]; then
  echo "External monitor is disabled, enabling laptop monitor..."
  hyprctl dispatch dpms on "$laptop_monitor_name" # Enable the laptop monitor
else
  echo "External monitor is enabled, no changes made."
fi
