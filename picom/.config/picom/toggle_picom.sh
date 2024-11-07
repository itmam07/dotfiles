#!/bin/bash

if pgrep -x picom  > /dev/null
then
pkill picom
exit
fi

if ! pgrep -x picom 
then
picom -b --config ~/.config/picom/picom.conf > /dev/null
exit
fi
