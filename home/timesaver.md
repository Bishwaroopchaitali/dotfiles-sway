refresh swayosd
pkill -x swayosd-server && setsid swayosd-server > /dev/null 2>&1

refresh waybar
killall -SIGUSR2 waybar
