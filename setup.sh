#!/bin/bash

# Setup script for the server

profile_dir="/etc/profile.d"
bin_dir="/usr/bin"

# Delete previous files and copy new ones
for file in /root/mykrackenbot/profile/*; do
  filename="$(basename $file)"
  new_file="$profile_dir/$filename"
  if [ -f "$new_file" ]; then
    rm "$new_file"
  fi
  cp "$file" "$new_file"
  chown root:root "$new_file"
  chmod +x "$new_file"
done

for file in /root/mykrackenbot/bin/*; do
  filename="$(basename $file)"
  new_file="$bin_dir/$filename"
  if [ -f "$new_file" ]; then
    rm "$new_file"
  fi
  cp "$file" "$new_file"
  chown root:root "$new_file"
  chmod +x "$new_file"
done
