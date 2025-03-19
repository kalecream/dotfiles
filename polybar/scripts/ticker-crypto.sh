#!/bin/sh

API="https://api.kraken.com/0/public/Ticker"
PAIR=BTCUSD

quote=$(curl -sf $API?pair=$PAIR | jq -r ".result.XXBTZUSD.c[0]")
quote=$(LANG=C printf "%.2f" "$quote")

echo "$quote"
