#!/bin/sh

uptime=`uptime | awk '{print $3 " " $4}' | sed 's/,.*//'`

echo " $uptime"