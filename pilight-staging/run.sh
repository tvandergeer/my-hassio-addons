#!/usr/bin/env bash

# Extract config data
CONFIG_PATH=/data/options.json
SENDER=$(jq -r '.sender // empty' "$CONFIG_PATH")
SENDER=${SENDER:-0} # default to none

GPIO_PLATFORM=$(jq -r '.gpioplatform // empty' "$CONFIG_PATH")
GPIO_PLATFORM=${GPIO_PLATFORM:-none} # default to none

RECEIVER=$(jq -r '.receiver // empty' "$CONFIG_PATH")
RECEIVER=${RECEIVER:--1} # default to none

echo $RECEIVER

# # Update pilight config
sed -i 's/\("gpio-platform"\): \?.*\(.*\)/\1: '$GPIO_PLATFORM'\2/' /etc/pilight/config.json
sed -i 's/\("receiver"\): \?.*\(.*\)/\1: '$RECEIVER'\2/' /etc/pilight/config.json
sed -i 's/\("sender"\): \?.*\(.*\)/\1: '$SENDER,'\2/' /etc/pilight/config.json

cat /etc/pilight/config.json

# Run pilight in foreground
exec /usr/local/sbin/pilight-daemon -F
