#!/bin/bash

export PATH="$HOME/.bin:$PATH"
export XDG_SESSION_TYPE=x11
export XDG_CURRENT_DESKTOP=dwm
export MOZ_X11_EGL=1

xsetroot -solid "#002b36"
brightnessctl set 40%
xset s off
xset dpms 300 600 600
xautolock -time 5 -locker slock &
dunst &
slstatus &
exec dwm
