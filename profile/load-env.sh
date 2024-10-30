#!/bin/bash

# Script that loads environment variables for the Telegram bot

ENV_FILE="/root/mykrackenbot/.env"

if [ -f "$ENV_FILE" ]; then
  export $(grep -v '^#' "$ENV_FILE" | xargs)
fi
