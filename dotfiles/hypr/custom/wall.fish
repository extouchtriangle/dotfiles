set DIR (random 1 11)
cd ~/Pictures/Wallpapers/$DIR
set FILE (find . -maxdepth 1 -type f | shuf -n 1)
caelestia wallpaper --file ~/Pictures/Wallpapers/$DIR/$FILE
~/.config/quickshell/ii/scripts/colors/switchwall.sh ~/Pictures/Wallpapers/$DIR/$FILE
disown %1
/usr/lib/plasma-changeicons breeze
exit
