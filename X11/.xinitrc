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

BAT_ICON () {
status=$( cat /sys/class/power_supply/BAT0/status )
cap="$( cat /sys/class/power_supply/BAT0/capacity )"

if (( $cap <= 10 ))
then
    if [[ $status == "Charging" ]]
    then
        STATUS="󰢟"
    elif [[ $status == "Discharging" ]]
    then
        STATUS="󰂎"
    fi
elif (( $cap > 10 && $cap <= 25 ))
then
    if [[ $status == "Charging" ]]
    then
        STATUS="󱊤"
    elif [[ $status == "Discharging" ]]
    then
        STATUS="󱊡"
    fi
elif (( $cap > 25 && $cap <=85 ))
then
    if [[ $status == "Charging" ]]
    then
        STATUS="󱊥"
    elif [[ $status == "Discharging" ]]
    then
        STATUS="󱊢"
    fi
elif (( $cap > 85 && $cap <=99 ))
then
    if [[ $status == "Charging" ]]
    then
        STATUS="󱊦"
    elif [[ $status == "Discharging" ]]
    then
        STATUS="󱊣"
    fi
fi
}

while true
do
#STATUS="test"
BAT_ICON

# RAM=$( free -m | grep '^Mem' | awk '{print  "100*"$3"/"$2 } ' | bc)

#SSID=$( nmcli dev wifi | grep -E "^[*]" | awk '{print $3}' )
WIFI=$( nmcli dev wifi | grep -E "^[*]" | awk '{print $8}' )

DATE=$( date +"%R %F" )

xsetroot -name " : ${WIFI}% $SEP $STATUS $SEP $DATE"
sleep 3
done &

# autoreload

#while true
#do
#dwm
#done

exec dwm
