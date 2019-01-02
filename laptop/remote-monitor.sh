#!/bin/bash

#idk what in this list actually needs to be here
export DISPLAY=:0
export COLORTERM=truecolor
export XDG_VTNR=2
export DESKTOP_SESSION=dwm
export XDG_SESSION_TYPE=x11
export XDG_DATA_DIRS=/usr/share/dwm:/usr/local/share/:/usr/share/
export XDG_SESSION_DESKTOP=dwm
export WINDOWPATH=2
export VTE_VERSION=5202
export XDG_SEAT=seat0
export GDMSESSION=dwm
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/400003190/bus
export XDG_RUNTIME_DIR=/run/user/400003190
export XAUTHORITY=/run/user/400003190/gdm/Xauthority
export XDG_CONFIG_DIRS=/etc/xdg/xdg-dwm:/etc/xdg

readonly INTERN="eDP-1"
readonly EXTERN="DP-1-1"

extern_on=0

echo "\"can't open display\" errors seem to happen from polling xrandr, trying to do checks for any newly attached monitors. these can be safely ignored as long as they stop eventually"

while :;
do
    if xrandr | grep "${EXTERN} connected" > /dev/null 2>&1 ;
    then
	if [[ ${extern_on} == 0 ]] ;
	then
            xrandr --output DP-1-1 --mode 1920x1080
	    ret=${?}
	    if [[ ${ret} == 0 ]] ;
	    then
	        extern_on=1
	    else
	        echo 'error configuring external monitor, trying again...'
	    fi
	fi
    elif xrandr | grep "${EXTERN} disconnected" > /dev/null 2>&1 ;
    then
	if [[ ${extern_on} == 1 ]] ;
	then
	    xrandr --output DP-1-1 --off
	    extern_on=0
	fi
    fi
    sleep 1
done
