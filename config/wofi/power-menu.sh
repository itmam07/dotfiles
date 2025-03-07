#!/bin/bash

choices="   Reboot\n   Shutdown\n   Suspend\n   Hibernate\n   Lock"

selected=$(echo -e "$choices" | wofi --dmenu -i --width=250 --height=250 --hide-scroll --cache-file=/dev/null)

case "$selected" in
  "   Reboot") systemctl reboot ;;
  "   Shutdown") systemctl poweroff ;;
  "   Suspend") systemctl suspend ;;
  "   Hibernate") systemctl hibernate ;;
  "   Lock") hyprlock ;;
  *) exit 1 ;;
esac

