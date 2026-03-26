#!/bin/bash

# Get currently focused workspace number
current_num=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused) | .num')

# represents the first command-line argument passed to this script, where the options can be "next" or "prev"
direction=$1 

if [[ "$direction" == "next" ]]; then
	target=$((current_num + 1))
	if [[ target -gt 6 ]]; then target=1; fi     # -gt stands for "greater than" rest should be self explainatory
elif [[ "$direction" == "prev" ]]; then
	target=$((current_num - 1))
	if [[ target -lt 1 ]]; then target=6; fi     # -lt stands for "less than" rest should be self explainatory
else 
	echo "Usage: $0 next|prev"
	exit 1
fi

swaymsg move window to workspace number $target       # Moves window to target workspace
swaymsg workspace number $target                      # Moves focus to target workspace

