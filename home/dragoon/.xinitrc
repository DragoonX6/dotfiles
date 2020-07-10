#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

exec bspwm -c ~/.config/bspwm/bspwmrc-gaming
