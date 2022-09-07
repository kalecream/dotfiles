#!/bin/sh
price() {
     curl -X 'GET' 'https://api.coingecko.com/api/v3/simple/price?ids='"$1"'&amp;vs_currencies=usd' -H 'accept: application/json' 2> /dev/null 
    sed  's/.*usd"://'
    sed 's/..$//'
    sed 's/^/\$/'
}

/usr/bin/i3status -c $HOME/.i3status.conf | while :
do
    read line

    bitcoin=$(price bitcoin)
    ethereum=$(price ethereum)
    echo "BTC ${bitcoin}    ETH ${ethereum}    "
    sleep 1m
done