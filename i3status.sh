#!/bin/sh
# boxes are fontawesome text icons
/usr/bin/i3status -c $HOME/.i3status.conf | while :
do
    read line
    localtime=$(date +'%a %d %b %Y %H:%M')
    worktime=$(TZ=UTC-2 date +'%H:%M')

    svolume=$(pactl  get-sink-volume $(pactl list short sinks |  awk '{print $1}' )  | sed -n 1p|  awk '{print " R" $5 " L" $12}')
    mem=$(free | sed -n 2p | awk '{printf "%s%.0f%s%.0f\n" ,  " ",$3/1024,"/",$7/1024}')
    RAM=`free -kh | grep Mem | awk '{print $3}'`
    TOTR=$(cat /proc/meminfo | grep MemT | sed 's/.*\://g' | sed 's/ *//g' | sed 's/kB//g')
    battery=$(upower -i $(upower -e | grep BAT) | grep  -E "state|to\ full|to\ empty|percentage" |  tr -d '\n' | sed 's/  */ /g')
    TOT=$(octave --eval "$TOTR/1024^2" | sed 's/ans = *//g' | sed 's/$/G/g' )
    VPN=$(ip a | grep tun | wc -l)
    VPN_STATUS=$(if [ $VPN -gt 0 ]; then echo " VPN ON"; else echo " VPN Off"; fi)
    ineta=$(ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'|  tr  '\n' ' ')
    internet=$(iwgetid -r)
    # add signal strength and ip to output

    # Put uptime
    uptime=`uptime | awk '{print $3 " " $4}' | sed 's/,.*//'`
    hour=$(echo $uptime | sed 's/\:.*//g')
    min=$(echo $uptime | sed 's/.*\://g')
    UP=" $hour h $min"
    

    echo "$UP    $localtime     $worktime     $svolume   $mem     $RAM  $TOTR     $battery    $TOT    $VPN_STATUS   $internet"
done
