# cyrillic font
# export LC_CTYPE="ru_RU.UTF-8"

# terminal
xrdb -merge ~/.config/X11/.Xresources
urxvtd -o -q -r
udiskie &

# keyboard 
setxkbmap -option 'caps:ctrl_modifier';xcape -e 'Caps_Lock=Escape'&
setxkbmap -layout us,ru && setxkbmap -option 'grp:win_space_toggle'

#   ╭───────────╮
#   │ wallpaper │
#   ╰───────────╯

feh --bg-scale /home/rustam/new_dotfiles/images/wallpaper.jpg

#   ╭────────────╮
#   │ status bar │
#   ╰────────────╯

SEP="|"
BAT_PATH="/sys/class/power_supply/BAT0/capacity"

BAT_STATUS () {
status=$( cat /sys/class/power_supply/BAT0/status )
if [[ $status == "Charging" ]]
then
    #STATUS="UP"
    STATUS="󰢝"
elif [[ $status == "Discharging" ]]
then
    #STATUS="DOWN"
    STATUS="󰁾"
fi
}

while true
do

BAT="$( cat $BAT_PATH ) %"
BAT_STATUS

RAM=$( free -m | grep '^Mem' | awk '{print  "100*"$3"/"$2 } ' | bc)

DATE=$( date +"%R %F" )

xsetroot -name " RAM: ${RAM}% $SEP $STATUS $BAT $SEP $DATE"
sleep 10
done &

# autoreload

#while true
#do
#dwm
#done

exec dwm
