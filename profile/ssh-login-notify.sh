#!/bin/bash

# Bot that controls the SSH Login activities on the server

login_ip="$(echo $SSH_CONNECTION | cut -d " " -f 1)"
login_date="$(date +"%e %b %Y, %a %r")"
login_name="$(whoami)"

message="New SSH login to server"$'\n'"$login_name"$'\n'"$login_ip"$'\n'"$login_date"

telegram-send "$message"
