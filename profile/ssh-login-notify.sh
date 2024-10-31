#!/bin/bash

# Script that controls the SSH Login activities on the server

login_ip="$(echo $SSH_CONNECTION | cut -d " " -f 1)"
login_user="$(whoami)"
login_date="$(date +"%e %b %Y")"
login_time="$(date +", %a %r")"

message=$(cat <<EOF
**New SSH Login to server:**
───────────────────────────────
Username: __"$login_user"__
IP: __"$login_ip"__
Date: __"$login_date"__
Time: __"$login_time"__
───────────────────────────────
🔐 **__Please ensure you recognize this login.__**
EOF
)

telegram-send.py "/root/mykrackenbot/.env" "$message"
