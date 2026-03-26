# Instructions

- WM: swayfx
- Lock screen: swaylock, copy the theme & format I chose for login tui, make it into a wallpaper, and then use swaylock indicator and place it somewhere appropriate where it fits, and it should look cohesive with the login greeter
- Login: sysc-greet using greetd (https://github.com/Nomadcxx/sysc-greet)
- Sound: Native pipewire + wiremix tui (https://github.com/tsowell/wiremix)
- idle settings: Sway idle
- wifi: using native network-manager, wifitui or nmtui-go or impala 
[(https://github.com/shazow/wifitui?tab=readme-ov-file) (https://github.com/doeixd/nmtui-go) (https://github.com/pythops/impala)]
- lock screen: sway lock native package, but use custom circular shape Wallpaper complementary to the shape of the lock 
- bluetooth: bluetui (https://github.com/pythops/bluetui)
- clipboard: clipse tui using wl-clipboard (https://github.com/savedra1/clipse)
- bar: waybar (Add privacy markers 
Showing if microphone is on, or camera is on or screen is being recorded, make every module clickable such that a tui open for the following module, it should have modules in the following order from left to right,

Left area: power on/off (using wlogout), followed by workspace indicator

Middle area: show application icon of what application is open/taskbar kinda

Right area: notification panel, bluetooth module, sound module, clipboard module, wifi module, brightness module which if clicked should activate warm temperature using my script, battery, date and time)

- OSD: for audio, brightness, temperature : dunst 
- launcher: rofi (already configured) but another emoji picker is needed use this repo if useful for that https://github.com/vyrx-dev/dotfiles
- notification: swaync, (make sure I get reminders, holidays, birthdays, system changes and script completion notifications), (make sure it has sliders to control blur settings within it using sliders, has dark mode/light mode toggle, has screen record button and screen shot button and stuff for per window or whole screen)
- file manager: yazi, (make sure connecting external device such as my phone works(https://github.com/boydaihungst/gvfs.yazi?tab=readme-ov-file#preview), extracting files works properly, selecting what application to choose for opening any file works properly, be able to use my custom wallpaper applying script, and kde connect integration works properly, improve file opening for obscure files, like appimages, scripts, etc.)

and

Set an obsolete hotkey bind to activate yazi in a terminal through bashrc
And use a different obsolete hotkey that activates a script that opens a new kitty window with yazi open
Then use Xremap
https://github.com/xremap/xremap
For situational keymapping, through mod+e activate script hotkey if kitty is not in focus
And if kitty in focus, activate obsolete hotkey bind
____________________________________________
- remapping tool: xremap
(https://github.com/xremap/xremap)

The normal instructions on the xremap README are slightly wrong

Here's how to properly install without any errors on fedora for sway:

_#install it_
$: sudo dnf copr enable blakegardner/xremap

$: sudo dnf install xremap-wlroots
___

_#check if your user is in "input" group_
$: id $USER

_#if output shows you are in input group then continue, otherwise create the "input" group and add your user to it_
$: sudo groupadd input
$: sudo usermod -aG input $USER   

_#check if it worked_
$: id $USER
___

_#run this_
$: echo 'KERNEL=="uinput", GROUP="input", TAG+="uaccess", MODE:="0660", OPTIONS+="static_node=uinput"' | sudo tee /etc/udev/rules.d/input.rules

___

_#xremap won't run without a config file so create one, and put in this default config just for check if it works first_
$: mkdir -p ~/.config/xremap/

$: nvim ~/.config/xremap/config.yml

config.yml :
modmap:
  - name: Except Chrome
    application:
      not: Google-chrome
    remap:
      CapsLock: Esc
keymap:
  - name: Emacs binding
    application:
      only: Slack
    remap:
      C-b: left
      C-f: right
      C-p: up
      C-n: down

___

_#now Reboot your computer first, otherwise it won't work_

___

_#now xremap should run without root permissions, test it by bashing_
$: xremap ~/.config/xremap/config.yml

_it should output your devices such as mouses keyboards etc, and keep blinking the cursor, indicating the daemon works_

___

_#make it permanent by executing it everytime on, startup and also, when your config is reloaded, add this to your sway config :_

~/.config/sway/config :
exec_always xremap ~/.config/xremap/config.yml

___

https://github.com/xremap/xremap/discussions/638

Security concerns with xremap fix via choosing the second solution and change the installation process
____________________________________________
- editor: terminal -> Lazyvim, gui -> Zed
https://gist.github.com/oca159/0b480ed6555056418905b6e59af33674

https://gist.github.com/oca159/596dc2030c8593045e97a8d8509ff996

Use these 2 links for zed settings to match with lazyvim keymaps

- browser: zen browser (app img), and chromium (lightweight and foss version)
- video player: mpv
- screenshot tool: grim
- terminal: kitty (make sure transparancy effects are utilized instead of lowering opacity throught the compositor for blur background, because it sacrifices text visibility)
- screen recording tool: kooha
- image viewer: feh
- pdf viewer: Zathura
- fonts : san francisco (apple font) for
everything on browser, rofi and top bar, and Caskaydia cove for all terminal and text stuff like zed
- System monitor: btop
- Misc: Obsidian, good VM manager, reddit(https://github.com/ck-zhang/reddix) and YouTube(https://github.com/Benexl/yt-x) clients in the terminal, calender tui(https://github.com/anufrievroman/calcure), voice to text using whisper (https://github.com/openai/whisper), screenshot to text or conversion using tesseract (https://github.com/tesseract-ocr/tesseract), maintain a document keeping track of all my keybinds, setup
xdg-desktop-portal-wlr
xdg-desktop-portal-gtk (screen sharing, file pickers)

- Theming: Matugen for tui colors, zed and Obsidian

For obsidian see this dotfile and analyze how they did it https://github.com/dusklinux/dusky/blob/main/.config/matugen/templates/obsidian-theme.css
___
https://github.com/Maciejonos/dotfiles/tree/master/config/matugen/templates
Use this and see how "bjarneo/aether.nvim" was used in
matugen config for lazyvim coloring.
___
gtk theme -> graphite dark https://github.com/vinceliuice/Graphite-gtk-theme (guide video - https://youtu.be/uEwviUB7ktM)
___
Sharp black mouse with no tail
Custom monochrome white and black icons for all applications I use

- scripts: already the ones I made, update all appimages via appimageupdatetool (cli)
