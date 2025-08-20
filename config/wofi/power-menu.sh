#!/bin/bash

choices="   Shutdown\n   Reboot\n   Suspend\n   Hibernate\n   Lock"

selected=$(echo -e "$choices" | wofi --dmenu -i --width=250 --height=250 --hide-scroll --cache-file=/dev/null)

case "$selected" in
  "   Shutdown") systemctl poweroff ;;
  "   Reboot") systemctl reboot ;;
  "   Suspend") systemctl suspend ;;
  "   Hibernate") systemctl hibernate ;;
  "   Lock") hyprlock ;;
  *) exit 1 ;;
esac

