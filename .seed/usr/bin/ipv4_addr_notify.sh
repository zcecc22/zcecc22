#!/bin/sh

IFACE=enp1s0f1
STORE="/tmp/${IFACE}_ipv4"
CK=""
AK=""
AS=""
DOMAIN="frentzel.eu"
SUBDOMAIN="nodex"

touch "$STORE" >/dev/null 2>&1

PREVIOUS=$(cat "$STORE")
CURRENT=$(curl -s "http://192.168.178.1:49000/igdupnp/control/WANIPConn1" -H "Content-Type: text/xml; charset="utf-8"" -H "SoapAction:urn:schemas-upnp-org:service:WANIPConnection:1#GetExternalIPAddress" -d "<?xml version='1.0' encoding='utf-8'?> <s:Envelope s:encodingStyle='http://schemas.xmlsoap.org/soap/encoding/' xmlns:s='http://schemas.xmlsoap.org/soap/envelope/'> <s:Body><u:GetExternalIPAddress xmlns:u=""urn:schemas-upnp-org:service:WANIPConnection:1"" /></s:Body></s:Envelope>" | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')

if [ "$PREVIOUS" != "$CURRENT" ];
then
  echo "$CURRENT" > "$STORE"
  ovh_domain_update "$CK" "$AK" "$AS" 'A' "$DOMAIN" "$SUBDOMAIN" "$CURRENT"
fi
