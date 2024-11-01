#!/usr/bin/env python3

# Script that sends messages from the Telegram bot

import asyncio
import telegram
import sys
import os
from dotenv import load_dotenv
from typing import Tuple

def get_env(env_file: str) -> Tuple[str, str]:
  load_dotenv(env_file)
  bot_token = os.getenv("BOT_TOKEN")
  channel_id = os.getenv("CHANNEL_ID")
  if not bot_token or not channel_id:
    print("Error: BOT_TOKEN or CHANNEL_ID not found in the .env file.")
    sys.exit(1)
  return bot_token, channel_id

def get_args() -> Tuple[str, str]:
  if len(sys.argv) < 3 or (len(sys.argv) > 1 and sys.argv[1] in ("-h", "--help")):
    print(f"Usage: {os.path.basename(__file__)} <env_file> \"<text message>\"")
    sys.exit(0)

  if len(sys.argv) != 3:
    print("Error: You can pass only two arguments: <env_file> and \"<text message>\".")
    sys.exit(1)
  
  return sys.argv[1], sys.argv[2]

async def send_message(bot_token: str, channel_id: str, message: str) -> None:
  try:
    bot = telegram.Bot(token=bot_token)
    await bot.send_message(chat_id=channel_id, text=message, parse_mode='HTML')
    print("Message sent successfully!")
  except telegram.error.TelegramError as e:
    print(f"Failed to send message: {e}")
    sys.exit(1)

async def main():
  env_file, message = get_args()
  bot_token, channel_id = get_env(env_file)
  await send_message(bot_token, channel_id, message)

if __name__ == "__main__":
  asyncio.run(main())