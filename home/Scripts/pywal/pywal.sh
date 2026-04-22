#!/usr/bin/env bash

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

wal -i "$source" -s -t &>/dev/null &
wait $!
color_source=$HOME/.cache/wal/colors

#Check if the user provided a file argument
if [ -z "$color_source" ]; then
  echo "Usage: $0 <color_file.txt>"
  exit 1
fi

#Read the hex codes from the file into an array called 'colors'
mapfile -t colors <"$color_source"

#Display the colors with their corresponding numbers
echo "Pick a color from the list:"
echo ""
for i in "${!colors[@]}"; do
  hex="${colors[$i]}"
  # Clean hex code for conversion
  clean_hex="${hex#\#}"
  r=$((16#${clean_hex:0:2}))
  g=$((16#${clean_hex:2:2}))
  b=$((16#${clean_hex:4:2}))

  # Render line with alignment: %2d ensures numbers 1-9 have a leading space
  printf "[%2d] %s \033[48;2;%s;%s;%sm  \033[0m\n" "$((i + 1))" "$hex" "$r" "$g" "$b"
done

#Prompt the user to enter a number
echo ""
read -p "Enter number: " choice

#Convert the selection to a 0-based index and validate it
index=$((choice - 1))

if [[ $index -ge 0 && $index -lt ${#colors[@]} ]]; then
  # Assign the chosen hex code to the variable $fg
  fg="color$index"
  fg_in_hex="${colors[$index]}"
  echo "Success: Variable \$fg is now set to $fg"
  echo "---------------------------------"
else
  echo "Error: Invalid selection."
  exit 1
fi

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

cp $HOME/Scripts/pywal/waybar-colors.css $HOME/Scripts/pywal/waybar-colors-modified.css &
wait $!
sed -i "s/dummie/$fg/g" $HOME/Scripts/pywal/waybar-colors-modified.css
if [[ $? -ne 0 ]]; then
  echo "Something went wrong..."
  exit 1
fi
mv $HOME/Scripts/pywal/waybar-colors-modified.css $HOME/.config/wal/templates/waybar-colors.css
if [[ $? -eq 0 ]]; then
  echo "Waybar colors transferred "
else
  echo "Waybar failed to transfer colors "
fi
#-----------------------------------------------------------------------------------------#
cp $HOME/Scripts/pywal/rofi-colors.rasi $HOME/Scripts/pywal/rofi-colors-modified.rasi &
wait $!
sed -i "s/dummie/$fg/g" $HOME/Scripts/pywal/rofi-colors-modified.rasi
if [[ $? -ne 0 ]]; then
  echo "Something went wrong..."
  exit 1
fi
mv $HOME/Scripts/pywal/rofi-colors-modified.rasi $HOME/.config/wal/templates/rofi-colors.rasi
if [[ $? -eq 0 ]]; then
  echo "Rofi colors transferred "
else
  echo "Rofi failed to transfer colors "
fi
#-----------------------------------------------------------------------------------------#
cp $HOME/Scripts/pywal/sway-colors.conf $HOME/Scripts/pywal/sway-colors-modified.conf &
wait $!
sed -i "s/dummie/$fg/g" $HOME/Scripts/pywal/sway-colors-modified.conf
if [[ $? -ne 0 ]]; then
  echo "Something went wrong..."
  exit 1
fi
mv $HOME/Scripts/pywal/sway-colors-modified.conf $HOME/.config/wal/templates/sway-colors.conf
if [[ $? -eq 0 ]]; then
  echo "Sway colors transferred "
else
  echo "Sway failed to transfer colors "
fi
#-----------------------------------------------------------------------------------------#
cp $HOME/Scripts/pywal/swayosd-colors.css $HOME/Scripts/pywal/swayosd-colors-modified.css &
wait $!
sed -i "s/dummie/$fg/g" $HOME/Scripts/pywal/swayosd-colors-modified.css
if [[ $? -ne 0 ]]; then
  echo "Something went wrong..."
  exit 1
fi
mv $HOME/Scripts/pywal/swayosd-colors-modified.css $HOME/.config/wal/templates/swayosd-colors.css
if [[ $? -eq 0 ]]; then
  echo "Swayosd colors transferred "
else
  echo "Swayosd failed to transfer colors "
fi
#-----------------------------------------------------------------------------------------#
cp $HOME/Scripts/pywal/kitty-colors.conf $HOME/Scripts/pywal/kitty-colors-modified.conf &
wait $!
sed -i "s/dummie/$fg/g" $HOME/Scripts/pywal/kitty-colors-modified.conf
if [[ $? -ne 0 ]]; then
  echo "Something went wrong..."
  exit 1
fi
mv $HOME/Scripts/pywal/kitty-colors-modified.conf $HOME/.config/wal/templates/kitty-colors.conf
if [[ $? -eq 0 ]]; then
  echo "Kitty colors transferred "
else
  echo "Kitty failed to transfer colors "
fi
#!!!---------------------------------------!!!----------------------------------------!!!#
cp $HOME/Scripts/pywal/yazi-theme.toml $HOME/Scripts/pywal/yazi-theme-modified.toml
wait $!
sed -i "s/dummie/$fg_in_hex/g" $HOME/Scripts/pywal/yazi-theme-modified.toml
if [[ $? -ne 0 ]]; then
  echo "Something went wrong..."
  exit 1
else
  echo "Yazi colors transferred "
fi
#!!!---------------------------------------!!!----------------------------------------!!!#

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

wal -r &>/dev/null &
wait $!

mv ~/.cache/wal/waybar-colors.css ~/.config/waybar/colors.css
pkill -SIGUSR2 waybar
if [[ $? -eq 0 ]]; then
  echo "---------------------------------"
  echo "Waybar reloaded "
else
  echo "Waybar failed to reload "
fi

mv ~/.cache/wal/rofi-colors.rasi ~/.config/rofi/colors.rasi
if [[ $? -eq 0 ]]; then
  echo "Rofi reloaded "
else
  echo "Rofi failed to reload "
fi

mv ~/.cache/wal/sway-colors.conf ~/.config/sway/config.d/colors.conf
swaymsg reload
if [[ $? -eq 0 ]]; then
  echo "Sway reloaded "
else
  echo "Sway failed to reload "
fi

mv ~/.cache/wal/swayosd-colors.css ~/.config/swayosd/colors.css
pkill swayosd-server &
wait $!
swayosd-server &>/dev/null &
if [[ $? -eq 0 ]]; then
  echo "Swayosd reloaded "
else
  echo "Swayosd failed to reload "
fi

mv ~/.cache/wal/kitty-colors.conf ~/.config/kitty/themes/Pywal.conf
kitty +kitten themes --reload-in=all Pywal
if [[ $? -eq 0 ]]; then
  echo "Kitty reloaded "
else
  echo "Kitty failed to reload "
fi

#!!!---------------------------------------!!!----------------------------------------!!!#
mv ~/Scripts/pywal/yazi-theme-modified.toml ~/.config/yazi/theme.toml
if [[ $? -eq 0 ]]; then
  echo "Yazi reloaded "
else
  echo "Yazi failed to reload "
fi
#!!!---------------------------------------!!!----------------------------------------!!!#

exit 0
