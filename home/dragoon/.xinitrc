#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

setxkbmap us altgr-intl &
xset b 100 &
xset mouse 2 10 &
numlockx &

sudo beesvc start

[ ! -s ~/.config/mpd/pid ] && mpd

exec openbox-session

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
