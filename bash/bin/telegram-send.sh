#!/bin/bash

# Script that sends messages from the Telegram bot

if [ -z "$1" -o "$1" == "-h" -o "$1" == "--help" ]; then
  echo "Usage: `basename $0` \"text message\""
  exit 0
fi

if [ "$#" -ne 1 ]; then
  echo "You can pass only one argument. For string with spaces put it on quotes."
  exit 0
fi

curl -s --data "text=$1" --data "chat_id=$CHANNEL_ID" 'https://api.telegram.org/bot'$BOT_TOKEN'/sendMessage' > /dev/null
