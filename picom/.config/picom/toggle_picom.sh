#!/bin/bash

if pgrep -x picom > /dev/null
then
pkill picom
exit
fi

if ! pgrep -x picom > /dev/null
 
then
picom --animations -b > /dev/null
exit
fi
