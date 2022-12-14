#!/bin/sh
# Source: https://github.com/LukeSmithxyz/voidrice/blob/master/.local/bin/statusbar/sb-volume

# Prints the current volume or đ if muted.

case $BLOCK_BUTTON in
	1) setsid -f "$TERMINAL" -e pulsemixer ;;
	2) pamixer -t ;;
	4) pamixer --allow-boost -i 1 ;;
	5) pamixer --allow-boost -d 1 ;;
	3) notify-send "đ Volume module" "\- Shows volume đ, đ if muted.
- Middle click to mute.
- Scroll to change." ;;
	6) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

vol="$(wpctl get-volume @DEFAULT_AUDIO_SINK@)"

# If muted, print đ and exit.
[ "$vol" != "${vol%\[MUTED\]}" ] && echo īĒ && exit

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
	$((vol >= 70)) ) icon="ī¨" ;;
	$((vol >= 30)) ) icon="īŠŊ" ;;
	$((vol >= 1)) ) icon="ī§" ;;
	* ) icon="īą" ;;
esac

echo "$icon $vol%"
