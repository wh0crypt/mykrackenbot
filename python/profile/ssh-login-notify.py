#!/usr/bin/env python3

# Script that controls the SSH Login activities on the server

import getpass
import subprocess
import sys
import os
from datetime import datetime
from typing import Tuple

def get_ssh_info() -> Tuple[str, str, str, str]:
  login_ip = os.getenv("SSH_CONNECTION").split()[0]
  login_user = getpass.getuser()
  login_date = datetime.now().strftime("%-d %b %Y")
  login_time = datetime.now().strftime(", %a %I:%M:%S %p")
  return login_ip, login_user, login_date, login_time

def get_message() -> str:
  ip, user, date, time = get_ssh_info()
  message = f"""**New SSH Login to server:**
  ───────────────────────────────
  Username: __{user}__
  IP: __{ip}__
  Date: __{date}__
  Time: __{time}__
  ───────────────────────────────
  🔐 **__Please ensure you recognize this login.__**"""
  return message

def main():
  result = subprocess.run(["telegram-send.py", "/root/mykrackenbot/.env", get_message()], capture_output=True, text=True) 

  if result.returncode != 0:
    print("Error: Failed to send message to Telegram.")
    sys.exit(1)

if __name__ == "__main__":
  main()