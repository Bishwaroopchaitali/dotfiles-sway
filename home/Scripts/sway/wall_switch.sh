#!/bin/bash

# the %f flag of thunar will be used as the first argument for this script which provides the path of the selected file along with its file name
# the %d flag of thunar will be used as the second argument for this script which provides the path of the selected file
wall_file_path_and_filename=$1
wall_file_path=$2

#Checking if the file chosen is already a png, as I have hardcoded my wallpaper location and file name
if [[ "$wall_file_path_and_filename" == *.png ]]; then
	#remove any file in the "active" directory
        rm ~/Wallpapers/static/active/*
	#send a copy of the selected file in the "active" directory with the following file name as written
        cp "$wall_file_path_and_filename" ~/Wallpapers/static/active/current_wallpaper.png
        swaymsg reload
else
	#use my custom img conversion script to convert the selected img, where the first argument is the format I want to convert to, second being the directory in which the converted file will be sent, and the last argument being the file name + path
	cd ~/bin/thunar/ && ./img_conv.sh png $wall_file_path $wall_file_path_and_filename
	#remove any file in the "active" directory
        rm ~/Wallpapers/static/active/*
	#utilizing the first argument provided to script, but stripping out the previous extension name from to string and adding ".png" such that the converted img is sent to "active" directory.
        cp "${wall_file_path_and_filename%.*}.png" ~/Wallpapers/static/active/current_wallpaper.png
        swaymsg reload
fi
