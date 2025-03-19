#!/bin/bash
#!/usr/bin/env sh
# olybar --log=trace --config=~/.config/polybar/config.ini bottomOne & bottomTwo & bottomThree

name=bottomOne
monitor=eDp-1

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
  for monitor in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=${monitor} polybar --reload ${name}&
  done
else
  polybar --reload ${name} &
fi