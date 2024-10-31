#!/usr/bin/env python3

# Setup script for the server

import os
import shutil
import stat

profile_dir = "/etc/profile.d"
bin_dir = "/usr/bin"
source_profile_dir = "/root/mykrackenbot/profile"
source_bin_dir = "/root/mykrackenbot/bin"

profile_dir = "/etc/profile.d"
bin_dir = "/usr/bin"
source_profile_dir = "/root/mykrackenbot/profile"
source_bin_dir = "/root/mykrackenbot/bin"

def setup_files(source_dir, target_dir):
  if os.path.isdir(source_dir):
    for filename in os.listdir(source_dir):
      source_file = os.path.join(source_dir, filename)
      target_file = os.path.join(target_dir, filename)

      if os.path.isfile(source_file):
        if os.path.isfile(target_file):
          os.remove(target_file)

        shutil.copy2(source_file, target_file)
        os.chown(target_file, 0, 0)  # Change owner to root
        os.chmod(target_file, stat.S_IRUSR | stat.S_IWUSR | stat.S_IXUSR |  # User
                  stat.S_IRGRP | stat.S_IXGRP |  # Group
                  stat.S_IROTH | stat.S_IXOTH)  # Others
  else:
    print(f"Directory {source_dir} does not exist.")

setup_files(source_profile_dir, profile_dir)
setup_files(source_bin_dir, bin_dir)

print("Setup completed.")