#!/bin/sh
# Source:
# https://github.com/LukeSmithxyz/voidrice/blob/master/.local/bin/statusbar/sb-battery
#
# Modified by me for my preferences

# Prints all batteries, their percentage remaining and an emoji corresponding
# to charge status (🔌 for plugged up, 🔋 for discharging on battery, etc.).

case $BLOCK_BUTTON in
	3) notify-send "🔋 Battery module" "🔋: discharging
🛑: not charging
♻: stagnant charge
🔌: charging
⚡: charged
❗: battery very low!
- Scroll to change adjust xbacklight." ;;
	4) xbacklight -inc 10 ;;
	5) xbacklight -dec 10 ;;
	6) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

# Loop through all attached batteries and format the info
for battery in /sys/class/power_supply/BAT?*; do
  # If non-first battery, print a space separator.
  [ -n "${capacity+x}" ] && printf " "
  # Sets up the status and capacity
  capacity="$(cat "$battery/capacity" 2>&1)"
	# Will make a warn variable if discharging and low
	[ "$status" = "🔋" ] && [ "$capacity" -le 25 ] && warn="❗"
  case "$(cat "$battery/status" 2>&1)" in
    "Full") status="⚡" ;;
    "Discharging") status="🔋" 
      energy_now="$(cat "$battery/energy_now" 2>&1)"
      power_now="$(cat "$battery/power_now" 2>&1)"
      hrs_left=$(($energy_now / $power_now))
      mins_left=$(echo "scale=2; (($energy_now / $power_now) - $hrs_left) * 60" | bc)
      printf "%s%s%d%% %d:%02.0fh" "$status " "$warn" "$capacity" "$hrs_left" "$mins_left"; unset warn
      continue
      ;;
    "Charging") status="🔌" ;;
    "Not charging") status="ﮤ" ;;
    "Unknown") status="" ;;
    *) exit 1 ;;
  esac

	# Prints the info
	printf "%s%s%d%%" "$status " "$warn" "$capacity"; unset warn
done && printf "\\n"
