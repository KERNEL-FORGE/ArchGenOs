#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="archgenos"
iso_label="ARCHGENOS"
iso_publisher="ArchGenOS Project"
iso_application="ArchGenOS Linux"
iso_version="$(date +%Y.%m.%d)"
install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux' 'uefi.grub')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'zstd' '-Xcompression-level' '22')
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/root"]="0:0:750"
)
