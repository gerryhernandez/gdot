#!/bin/sh
# Initial source:
# https://github.com/LukeSmithxyz/voidrice/blob/master/.local/bin/statusbar/sb-clock
#
# Modified by me for my preferences


case $BLOCK_BUTTON in
	1) notify-send "This Month" "$(cal --color=always | sed "s/..7m/<b><span color=\"red\">/;s|..27m|</span></b>|")" && notify-send "Appointments" "$(calcurse -d3)" ;;
	2) setsid -f "$TERMINAL" -e calcurse ;;
	3) notify-send "📅 Time/date module" "\- Left click to show upcoming appointments for the next three days via \`calcurse -d3\` and show the month via \`cal\`
- Middle click opens calcurse if installed" ;;
	6) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

date "+%a %Y-%m-%d %I:%M%p"
