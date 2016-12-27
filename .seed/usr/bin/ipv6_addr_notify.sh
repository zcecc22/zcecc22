#!/bin/sh

IFACE=br0
STORE="/tmp/${IFACE}_ipv6"
CK=""
AK=""
AS=""
DOMAIN="frentzel.eu"
SUBDOMAIN="nodex"

touch "$STORE" >/dev/null 2>&1

PREVIOUS=$(cat "$STORE")
CURRENT=$(ip -6 addr show "$IFACE" | grep -ie "inet6.*mngtmpaddr" | grep -ive "fd00" | head -n 1 | awk '{print $2}' | cut -d '/' -f 1)

if [ "$PREVIOUS" != "$CURRENT" ];
then
  echo "$CURRENT" > "$STORE"
  ovh_domain_update "$CK" "$AK" "$AS" 'AAAA' "$DOMAIN" "$SUBDOMAIN" "$CURRENT"
fi
