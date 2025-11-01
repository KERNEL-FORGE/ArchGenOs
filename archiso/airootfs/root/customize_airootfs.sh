#!/bin/bash

set -e

# Enable snapd service
systemctl enable snapd.socket

# Create a temporary user to build AUR packages
useradd -m builder
echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Switch to the builder user to build tlauncher
sudo -u builder bash <<'EOF'
cd /tmp
git clone https://aur.archlinux.org/tlauncher.git
cd tlauncher
makepkg -si --noconfirm
EOF

# Clean up
userdel -r builder
sed -i '$ d' /etc/sudoers
