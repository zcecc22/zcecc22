#!/bin/sh

HOST="google.com"
STORE="/tmp/vpn_check"
MAX_TRY=3

touch "$STORE" >/dev/null 2>&1

COUNTER=$(cat "$STORE")

ping -I tun0 -q -c 1 -W 30 $HOST >/dev/null 2>&1

if [ "$?" -ne 0 ]
then
  COUNTER=$(( $COUNTER + 1 ))
  if [ "$COUNTER" -eq "$MAX_TRY" ]
  then
    systemctl restart openvpn >/dev/null 2>&1
    rm "$STORE"
  else
    echo "$COUNTER" > "$STORE"
  fi
else
  rm "$STORE"
fi
