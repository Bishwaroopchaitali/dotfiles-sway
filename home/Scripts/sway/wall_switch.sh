#!/bin/bash

# acts as the first argument to record file path
source=$1

# removes all files from "~/Wallpapers/Active/" directory
rm -f ~/Wallpapers/Active/*

# this variable records the extension of the file provided
extension="${source##*.}"

# pause for 2 second just for safety
sleep 2

# copies the file to "~/Wallpapers/Active/" and renames it current_wallpaper with its respective extension
cp $source ~/Wallpapers/Active/current_wallpaper.$extension

# matugen
matugen image $source
