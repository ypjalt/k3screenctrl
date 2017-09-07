#!/bin/sh
. /etc/openwrt_release

PRODUCT_NAME_FULL=$(cat /etc/board.json | jsonfilter -e "@.model.name")
PRODUCT_NAME=${PRODUCT_NAME_FULL#* } # Remove first word to save space

WAN_IFNAME=$(uci get network.wan.ifname)
MAC_ADDR=$(ifconfig $WAN_IFNAME | grep -oE "([0-9A-Z]{2}:){5}[0-9A-Z]{2}")


RUPTIME=$(awk '{print int($1/86400)"Days "int($1%86400/3600)"h "int(($1%3600)/60)"m"}' /proc/uptime)
LAN_ADDR=`ifconfig br-lan |grep -w "inet addr"| awk '{print $2}'|awk -F':' '{print $2}' 2>/dev/null`
[ -z "$LAN_ADDR" ] && LAN_ADDR=`uci get network.lan.ipaddr 2>/dev/null`
[ -z "$LAN_ADDR" ] && LAN_ADDR="p.to"

HW_VERSION=$(uname -r)
FW_VERSION=${DISTRIB_ID}" "${DISTRIB_RELEASE}" "${DISTRIB_REVISION}
CPU_TEMP=$(($(cat /sys/class/thermal/thermal_zone0/temp)/1000))

echo $PRODUCT_NAME" "$CPU_TEMP"'C"
echo $HW_VERSION
echo $LAN_ADDR
echo $RUPTIME
