#!/usr/bin/env bash
set -eo pipefail

DISK_SIZE=4194304
DISK_NAME=RAMDisk

MOUNT_VOLUME="$(hdiutil attach -nomount ram://${DISK_SIZE} | tr -d '[:space:]')"

# create and mount RAMDisk
# HFS+
echo "diskutil erasevolume HFS+ ${DISK_NAME} \"${MOUNT_VOLUME}\""
diskutil erasevolume HFS+ ${DISK_NAME} "${MOUNT_VOLUME}" || exit 1
# APFS
# diskutil partitionDisk `hdiutil attach -nomount ram://${DISK_SIZE}` 1 apfs ${DISK_NAME} ${DISK_SIZE}

# create links to RAMDisk
function symbolic_link(){
  rm -rf "$1"
  rm -rf "$2"
  mkdir -p "$2"
  ln -s "$2" "$1"
}

# symlink Chrome_Cache
SRC="${HOME}/Library/Caches/Google/Chrome"
DST="/Volumes/${DISK_NAME}/Caches/Chrome"
mkdir -p "${HOME}/Library/Caches/Google"
symbolic_link "${SRC}" "${DST}"

# Create Firefox Cache Directory
mkdir -p "/Volumes/${DISK_NAME}/Caches/Firefox"
