#!/bin/bash

asusctl profile -n > /dev/null

active_profile=$(asusctl profile -p | sed -n '2p')

notify-send "$active_profile"

