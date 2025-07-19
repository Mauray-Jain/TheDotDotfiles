#!/bin/sh

# Portal stuff

systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway

swaybg -i ~/Downloads/wallpapers/war_plane.jpg &
wl-paste --watch cliphist store &
waybar &
nm-applet &
# dunst &
