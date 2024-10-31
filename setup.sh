#!/bin/bash

# Setup script for the server

profile_dir="/etc/profile.d"
bin_dir="/usr/bin"

# Delete previous files and copy new ones
for file in ./profile/*; do
  filename="$(basename $file)"
  new_file="$profile_dir/$filename"
  if [ -f "$new_file" ]; then
    sudo rm "$new_file"
  fi
  sudo cp "$file" "$new_file"
  sudo chown root:root "$new_file"
  sudo chmod +x "$new_file"
done

for file in ./bin/*; do
  filename="$(basename $file .sh)"
  new_file="$bin_dir/$filename"
  if [ -f "$new_file" ]; then
    sudo rm "$new_file"
  fi
  sudo cp "$file" "$new_file"
  sudo chown root:root "$new_file"
  sudo chmod +x "$new_file"
done
