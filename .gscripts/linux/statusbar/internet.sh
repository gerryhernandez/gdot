#!/bin/sh
# Source:
# https://github.com/LukeSmithxyz/voidrice/blob/master/.local/bin/statusbar/sb-internet
#
# Modified by me for my preferences

# Show wifi 📶 and percent strength or 📡 if none.
# Show 🌐 if connected to ethernet
# Show 🔒 if a vpn connection is active

case $BLOCK_BUTTON in
	1) "$TERMINAL" -e nmtui; pkill -RTMIN+4 dwmblocks ;;
	3) notify-send "🌐 Internet module" "\- Click to connect
❌: wifi disabled
📡: no wifi connection
📶: wifi connection with quality
🔒: vpn is active
" ;;
	6) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

if grep -xq 'up' /sys/class/net/w*/operstate 2>/dev/null ; then
	wifiicon="$(awk '/^\s*w/ { print "📶", int($3 * 100 / 70) "% " }' /proc/net/wireless)"
elif grep -xq 'down' /sys/class/net/w*/operstate 2>/dev/null ; then
	grep -xq '0x1003' /sys/class/net/w*/flags && wifiicon="📡 " || wifiicon="❌ "
fi

printf "%s%s%s\n" "$wifiicon" "$(sed "s/down//;s/up/🌐/" /sys/class/net/e*/operstate 2>/dev/null)" "$(sed "s/.*/🔒/" /sys/class/net/tun*/operstate 2>/dev/null)" | xargs
