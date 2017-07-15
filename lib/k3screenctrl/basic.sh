#!/bin/sh
. /etc/openwrt_release

PRODUCT_NAME_FULL=$(cat /etc/board.json | jsonfilter -e "@.model.name")
PRODUCT_NAME=${PRODUCT_NAME_FULL#* } # Remove first word to save space

WAN_IFNAME=$(uci get network.wan.ifname)
MAC_ADDR=$(ifconfig $WAN_IFNAME | grep -oE "([0-9A-Z]{2}:){5}[0-9A-Z]{2}")

HW_VERSION=$(uname -r)
FW_VERSION=${DISTRIB_ID}" "${DISTRIB_RELEASE}" "${DISTRIB_REVISION}
CPU_TEMP=$(($(cat /sys/class/thermal/thermal_zone0/temp)/1000))

echo $PRODUCT_NAME" "$CPU_TEMP
echo $HW_VERSION
echo $FW_VERSION
echo $MAC_ADDR
