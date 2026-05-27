#!/bin/bash

export XDG_SESSION_TYPE=x11
export XDG_CURRENT_DESKTOP=GNOME
export MOZ_X11_EGL=1

exec gnome-session
