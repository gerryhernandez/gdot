#!/bin/sh
# Source: https://github.com/LukeSmithxyz/voidrice/blob/master/.local/bin/statusbar/sb-volume

# Prints the current volume or 🔇 if muted.

case $BLOCK_BUTTON in
	1) setsid -f "$TERMINAL" -e pulsemixer ;;
	2) pamixer -t ;;
	4) pamixer --allow-boost -i 1 ;;
	5) pamixer --allow-boost -d 1 ;;
	3) notify-send "🔊 Volume module" "\- Shows volume 🔊, 🔇 if muted.
- Middle click to mute.
- Scroll to change." ;;
	6) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

vol="$(wpctl get-volume @DEFAULT_AUDIO_SINK@)"

# If muted, print 🔇 and exit.
[ "$vol" != "${vol%\[MUTED\]}" ] && echo 婢 && exit

vol="${vol#Volume: }"
split() {
	# For ommiting the . without calling and external program.
	IFS=$2
	set -- $1
	printf '%s' "$@"
}
vol="$(split "$vol" ".")"
vol="${vol##0}"
vol=$((10#$vol))

case 1 in
	$((vol >= 70)) ) icon="" ;;
	$((vol >= 30)) ) icon="墳" ;;
	$((vol >= 1)) ) icon="" ;;
	* ) icon="ﱝ" ;;
esac

echo "$icon $vol%"
