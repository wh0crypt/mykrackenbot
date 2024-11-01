#!/bin/bash

# Script that controls the SSH Login activities on the server

login_ip="$(echo $SSH_CONNECTION | cut -d " " -f 1)"
login_user="$(whoami)"
login_date="$(date +"%e %b %Y")"
login_time="$(date +", %a %r")"

message="""
<b>New SSH Login to server:</b>
───────────────────────────────
Username: <i>"$login_user"</i>
IP: <i>"$login_ip"</i>
Date: <i>"$login_date"</i>
Time: <i>"$login_time"</i>
───────────────────────────────
🔐 <b><i>Please ensure you recognize this login.</i></b>
"""

telegram-send.py "/root/mykrackenbot/.env" "$message"